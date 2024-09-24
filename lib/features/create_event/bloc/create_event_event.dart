part of 'create_event_bloc.dart';

sealed class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override
  List<Object> get props => [];
}

class EventTypesLoad extends CreateEventEvent {
  const EventTypesLoad({required this.completer});
  final Completer? completer;

}
