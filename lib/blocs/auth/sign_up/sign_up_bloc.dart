import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoadingState());

      SupabaseClient supabaseClient = Supabase.instance.client;

      try {
        if (event is GetUserEvent) {
          Map<String, dynamic>? profile = await supabaseClient
              .from('profile')
              .select('*')
              .eq('user_id', supabaseClient.auth.currentUser!.id)
              .maybeSingle();

          await supabaseClient.auth.refreshSession();

          if (profile != null) {
            emit(
              SignUpSuccessState(
                userDetails: profile,
              ),
            );
          } else {
            emit(SignUpFailureState());
          }
        } else if (event is CreateUserEvent) {
          UserResponse res = await supabaseClient.auth.admin.createUser(
            AdminUserAttributes(
              email: event.email,
              phone: event.phoneNumber,
              password: event.password,
              emailConfirm: true,
              phoneConfirm: true,
            ),
          );

          if (res.user != null) {
            String path = await supabaseClient.storage.from('docs').upload(
                'proof/${DateTime.now().millisecondsSinceEpoch.toString()}${event.proofDoc.name}',
                File(event.proofDoc.path!));

            path = path.replaceRange(0, 5, '');

            Logger().wtf(path);

            await supabaseClient.from('profile').insert({
              'name': event.name,
              'email': event.email,
              'phone': event.phoneNumber,
              'proof_doc_url':
                  supabaseClient.storage.from('docs').getPublicUrl(path),
              'bank_name': event.bankName,
              'bank_ac_no': event.accountNo,
              'bank_ifsc': event.ifsc,
              'user_id': res.user!.id,
            });
            await supabaseClient.auth.signInWithPassword(
              email: event.email,
              password: event.password,
            );
            add(GetUserEvent());
          } else {
            emit(SignUpFailureState());
          }
        } else if (event is UpdateUserEvent) {
          AdminUserAttributes attributes = AdminUserAttributes(
            email: event.email,
            phone: event.phoneNumber,
            emailConfirm: true,
            phoneConfirm: true,
          );

          if (event.password.isNotEmpty) {
            attributes.password = event.password;
          }

          UserResponse res = await supabaseClient.auth.admin.updateUserById(
            supabaseClient.auth.currentUser!.id,
            attributes: attributes,
          );

          if (res.user != null) {
            await supabaseClient.from('profile').update({
              'name': event.name,
              'email': event.email,
              'phone': event.phoneNumber,
              'bank_name': event.bankName,
              'bank_ac_no': event.accountNo,
              'bank_ifsc': event.ifsc,
            }).eq('user_id', res.user!.id);

            add(GetUserEvent());
          } else {
            emit(SignUpFailureState());
          }
        } else if (event is DepositEvent) {
          if (event.withdraw) {
            await supabaseClient.from('profile').update({
              'deposit_amount': 0,
            }).eq('user_id', supabaseClient.auth.currentUser!.id);

            await supabaseClient.from('withdraw_request').insert(
              {
                'user_id': supabaseClient.auth.currentUser!.id,
              },
            );
          } else {
            await supabaseClient.from('profile').update({
              'deposit_amount': 500,
            }).eq('user_id', supabaseClient.auth.currentUser!.id);
          }
          add(GetUserEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(SignUpFailureState(message: e.toString()));
      }
    });
  }
}
