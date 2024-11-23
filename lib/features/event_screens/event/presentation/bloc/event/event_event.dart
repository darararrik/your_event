part of 'event_bloc.dart';

sealed class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class AddServiceEvent extends EventEvent {
  final AgencyServiceDto service;

  const AddServiceEvent(this.service);
}