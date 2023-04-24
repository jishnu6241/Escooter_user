import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'hubs_and_scooters_event.dart';
part 'hubs_and_scooters_state.dart';

class HubsAndScootersBloc
    extends Bloc<HubsAndScootersEvent, HubsAndScootersState> {
  HubsAndScootersBloc() : super(HubsAndScootersInitialState()) {
    on<HubsAndScootersEvent>((event, emit) async {
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder hubTable = supabaseClient.from('hub');
      SupabaseQueryBuilder rideTable = supabaseClient.from('ride');
      SupabaseQueryBuilder scooterTable = supabaseClient.from('scooter');
      SupabaseQueryBuilder profileTable = supabaseClient.from('profile');
      SupabaseQueryBuilder scooterComplaintTable =
          supabaseClient.from('complaint');

      try {
        if (event is GetAllHubsAndScootersEvent) {
          emit(HubsAndScootersLoadingState());
          //
          List<dynamic> hubs = [];

          if (event.query != null) {
            hubs = await hubTable
                .select('*')
                .or('name.ilike.%${event.query}%,address.ilike.%${event.query}%')
                .order('name', ascending: true);
          } else {
            hubs = await hubTable.select('*').order('name', ascending: true);
          }

          for (int i = 0; i < hubs.length; i++) {
            hubs[i]['scooters'] = await scooterTable
                .select('*')
                .eq('parked_hub_id', hubs[i]['id'])
                .eq('status', 'hold');
          }

          Map<String, dynamic>? currentRide = await rideTable
              .select('*')
              .eq('user_id', supabaseClient.auth.currentUser!.id)
              .eq('status', 'active')
              .maybeSingle();

          if (currentRide != null) {
            currentRide['scooter'] = await scooterTable
                .select('*')
                .eq('id', currentRide['scooter_id'])
                .single();
            currentRide['start_hub'] = await hubTable
                .select('*')
                .eq('id', currentRide['start_hub_id'])
                .single();
          }

          emit(HubsAndScootersSuccessState(
            hubsAndScooters: hubs,
            rideDetails: currentRide,
          ));
          //
        } else if (event is StartRideEvent) {
          emit(HubsAndScootersLoadingState());
          //

          Map<String, dynamic> profile = await profileTable
              .select('*')
              .eq('user_id', supabaseClient.auth.currentUser!.id)
              .single();

          if (profile['deposit_amount'] > 0) {
            List<dynamic>? currentRide = await rideTable
                .select('*')
                .eq('user_id', supabaseClient.auth.currentUser!.id)
                .eq('status', 'active');

            if (currentRide != null && currentRide.isNotEmpty) {
              emit(HubsAndScootersFailureState(
                  message:
                      'You already have a ride in progress, drop that scooter at a hub before you can book another'));
            } else {
              Map<String, dynamic>? scooterDetails = await scooterTable
                  .select('*')
                  .eq('id', event.scooterId)
                  .eq('key', event.key)
                  .maybeSingle();

              if (scooterDetails != null) {
                await rideTable.insert({
                  'scooter_id': event.scooterId,
                  'start_hub_id': event.hubId,
                  'user_id': supabaseClient.auth.currentUser!.id,
                });

                await scooterTable.update({
                  'status': 'ride',
                }).eq('id', event.scooterId);
                add(GetAllHubsAndScootersEvent());
              } else {
                emit(
                  HubsAndScootersFailureState(
                    message:
                        'Incorrect Key, Please check the key and try again.',
                  ),
                );
              }
            }
          } else {
            emit(
              HubsAndScootersFailureState(
                message:
                    'No security deposit found, deposit the security amount to book a ride.',
              ),
            );
          }

          //
        } else if (event is EndRideEvent) {
          emit(HubsAndScootersLoadingState());
          //
          Map<String, dynamic> rideDetails =
              await rideTable.select('*').eq('id', event.rideId).single();

          await scooterTable.update({
            'status': 'hold',
            'parked_hub_id': event.hubId,
            'key': generateRandom5DigitInt(),
          }).eq('id', rideDetails['scooter_id']);

          await rideTable.update({
            'end_hub_id': event.hubId,
            'end_time': DateTime.now().toIso8601String(),
            'amount': event.amount,
            'status': 'complete',
          }).eq('id', event.rideId);

          add(GetAllHubsAndScootersEvent());

          //
        } else if (event is ReportScooterEvent) {
          //

          Map<String, dynamic> rideDetails =
              await rideTable.select('*').eq('id', event.rideId).single();

          await scooterComplaintTable.insert({
            'scooter_id': rideDetails['scooter_id'],
            'complaint': event.complaint,
            'user_id': supabaseClient.auth.currentUser!.id,
          });
          //
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(HubsAndScootersFailureState());
      }
    });
  }
}

int generateRandom5DigitInt() {
  Random random = Random();
  int min = 10000; // minimum 5 digit integer
  int max = 99999; // maximum 5 digit integer
  return min + random.nextInt(max - min);
}
