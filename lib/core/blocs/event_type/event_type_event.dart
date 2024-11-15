part of 'event_type_bloc.dart';

sealed class EventTypeEvent extends Equatable {
  const EventTypeEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends EventTypeEvent {}
