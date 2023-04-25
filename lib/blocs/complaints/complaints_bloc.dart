import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'complaints_event.dart';
part 'complaints_state.dart';

class ComplaintsBloc extends Bloc<ComplaintsEvent, ComplaintsState> {
  ComplaintsBloc() : super(ComplaintInitialState()) {
    on<ComplaintsEvent>((event, emit) async {
      emit(ComplaintLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('complaint');
      SupabaseQueryBuilder scooterTable = supabaseClient.from('scooter');
      try {
        if (event is GetAllComplaintEvent) {
          List<dynamic> temp = await queryTable
              .select()
              .eq('user_id', supabaseClient.auth.currentUser!.id)
              .order('created_at');

          List<Map<String, dynamic>> complaints =
              temp.map((e) => e as Map<String, dynamic>).toList();

          for (int i = 0; i < complaints.length; i++) {
            complaints[i]['scooter'] = await scooterTable
                .select('*')
                .eq('id', complaints[i]['scooter_id'])
                .single();
          }
          Logger().i(complaints);
          emit(
            ComplaintSuccessState(
              complaints: complaints,
            ),
          );
        } else if (event is AddComplaintEvent) {
          await queryTable.insert(
            {
              'user_id': supabaseClient.auth.currentUser!.id,
              'complaint': event.complaint,
            },
          );

          add(GetAllComplaintEvent());
        } else if (event is DeleteComplaintEvent) {
          await queryTable.delete().eq('id', event.complaintId);
          add(GetAllComplaintEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(ComplaintFailureState());
      }
    });
  }
}
