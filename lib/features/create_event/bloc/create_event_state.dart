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

  const EventTypesLoaded({required this.list}) ;
    @override
  List<Object> get props => [list];
  
  
}
class EventTypesError extends CreateEventState {
  final String error;

  const EventTypesError({required this.error});
    List<Object> get props => [error];

  
}