// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_event_bloc.dart';

sealed class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends CreateEventEvent {
  final Completer? completer;
  const LoadEvents({
    this.completer,
  });
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
    required String time,
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
