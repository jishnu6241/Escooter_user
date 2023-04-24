part of 'hubs_and_scooters_bloc.dart';

@immutable
abstract class HubsAndScootersEvent {}

class GetAllHubsAndScootersEvent extends HubsAndScootersEvent {
  final String? query;

  GetAllHubsAndScootersEvent({this.query});
}

class StartRideEvent extends HubsAndScootersEvent {
  final int scooterId, hubId, key;

  StartRideEvent({
    required this.scooterId,
    required this.hubId,
    required this.key,
  });
}

class EndRideEvent extends HubsAndScootersEvent {
  final int rideId, hubId, amount;

  EndRideEvent({
    required this.rideId,
    required this.hubId,
    required this.amount,
  });
}

class ReportScooterEvent extends HubsAndScootersEvent {
  final int rideId;
  final String complaint;

  ReportScooterEvent({required this.rideId, required this.complaint});
}
