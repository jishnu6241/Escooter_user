part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class CreateUserEvent extends SignUpEvent {
  final String name, email, phoneNumber, password, bankName, accountNo, ifsc;
  final PlatformFile proofDoc;

  CreateUserEvent({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.bankName,
    required this.accountNo,
    required this.ifsc,
    required this.proofDoc,
  });
}

class UpdateUserEvent extends SignUpEvent {
  final String name, email, phoneNumber, bankName, accountNo, ifsc, password;

  UpdateUserEvent({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.bankName,
    required this.accountNo,
    required this.ifsc,
  });
}

class DepositEvent extends SignUpEvent {
  final bool withdraw;

  DepositEvent({
    this.withdraw = false,
  });
}

class GetUserEvent extends SignUpEvent {}
