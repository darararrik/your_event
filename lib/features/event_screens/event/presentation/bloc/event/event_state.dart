// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_bloc.dart';

sealed class EventState extends Equatable {
  const EventState();
  @override
  List<Object> get props => [];
}

final class EventInitial extends EventState {}

class EventServiceAdded extends EventState {
  final List<AgencyServiceDto> services;
  final Map<String, List<AgencyServiceDto>> groupedServices;

  const EventServiceAdded({
    required this.services,
    required this.groupedServices,
  });
  @override
  List<Object> get props => [groupedServices, services];
}

class UpdateEvents extends EventState {
  final AgencyServiceDto service;
  const UpdateEvents({
    required this.service,
  });
  @override
  List<Object> get props => [service];
}
