part of 'hub_bloc.dart';

@immutable
abstract class HubState {}

class HubInitialState extends HubState {}

class HubLoadingState extends HubState {}

class HubSuccessState extends HubState {
  final List<Map<String, dynamic>> hubs;

  HubSuccessState({required this.hubs});
}

class HubFailureState extends HubState {
  final String message;
  HubFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
