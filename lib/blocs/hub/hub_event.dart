part of 'hub_bloc.dart';

@immutable
abstract class HubEvent {}

class DeleteHubEvent extends HubEvent {
  final int id;

  DeleteHubEvent({
    required this.id,
  });
}

class GetAllHubEvent extends HubEvent {
  final String? query;

  GetAllHubEvent({
    this.query,
  });
}
