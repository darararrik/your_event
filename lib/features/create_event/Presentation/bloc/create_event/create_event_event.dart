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

class SelectedEvent extends CreateEventEvent {}

class CreateEvent extends CreateEventEvent {
  final EventModel event;

  CreateEvent({
    required DateTime date,
    required String name,
    required String description,
    required TimeOfDay time,
    required String numberOfPeople,
    required String address,
    required String price,
  }) : event = EventModel(
            date: date,
            name: name,
            description: description,
            time: time,
            numberOfPeople: numberOfPeople,
            address: address,
            price: price);
  @override
  List<Object> get props => [event];
}
