// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_event_bloc.dart';

sealed class CreateEventState extends Equatable {
  const CreateEventState();

  @override
  List<Object> get props => [];
}


final class CreateEventInitial extends CreateEventState {}

class EventTypesLoading extends CreateEventState {}

class EventTypesLoaded extends CreateEventState {
  final List<EventTypeModel> list;

  const EventTypesLoaded({required this.list});
  @override
  List<Object> get props => [list];
}

class Error extends CreateEventState {
  final Object error;

  const Error({required this.error});
  @override
  List<Object> get props => [error];
}

class EventCreated extends CreateEventState {
  final EventModel event;
  const EventCreated(this.event);
  @override
  List<Object> get props => [event];
}

class Loading extends CreateEventState {}
