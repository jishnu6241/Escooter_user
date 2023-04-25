part of 'complaints_bloc.dart';

@immutable
abstract class ComplaintsEvent {}

class AddComplaintEvent extends ComplaintsEvent {
  final String complaint;
  final int scooterId;

  AddComplaintEvent({
    required this.complaint,
    required this.scooterId,
  });
}

class DeleteComplaintEvent extends ComplaintsEvent {
  final int complaintId;

  DeleteComplaintEvent({required this.complaintId});
}

class GetAllComplaintEvent extends ComplaintsEvent {
  final String? query;

  GetAllComplaintEvent({this.query});
}
