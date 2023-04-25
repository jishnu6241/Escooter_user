part of 'complaints_bloc.dart';

@immutable
abstract class ComplaintsState {}

class ComplaintInitialState extends ComplaintsState {}

class ComplaintLoadingState extends ComplaintsState {}

class ComplaintSuccessState extends ComplaintsState {
  final List<Map<String, dynamic>> complaints;

  ComplaintSuccessState({required this.complaints});
}

class ComplaintFailureState extends ComplaintsState {
  final String message;

  ComplaintFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
