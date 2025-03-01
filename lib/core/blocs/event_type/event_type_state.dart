// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_type_bloc.dart';

sealed class EventTypeState extends Equatable {
  const EventTypeState();

  @override
  List<Object> get props => [];
}

final class EventTypeInitial extends EventTypeState {}

class EventTypesLoaded extends EventTypeState {
  final List<EventTypeDto> list;
  const EventTypesLoaded({
    required this.list,
  });
  @override
  List<Object> get props => [list];
}

class EventTypesLoading extends EventTypeState {}

class EventTypesError extends EventTypeState {
  final Object error;
  const EventTypesError({
    required this.error,
  });
}
