part of 'hubs_and_scooters_bloc.dart';

@immutable
abstract class HubsAndScootersState {}

class HubsAndScootersInitialState extends HubsAndScootersState {}

class HubsAndScootersLoadingState extends HubsAndScootersState {}

class HubsAndScootersSuccessState extends HubsAndScootersState {
  final List<dynamic> hubsAndScooters;
  final Map<String, dynamic>? rideDetails;

  HubsAndScootersSuccessState(
      {required this.hubsAndScooters, required this.rideDetails});
}

class HubsAndScootersFailureState extends HubsAndScootersState {
  final String message;

  HubsAndScootersFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
