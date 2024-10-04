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

class StepOneEnter extends CreateEventEvent {
  final String name;
  final String description;
  final TimeOfDay time;
  final DateTime date;
  const StepOneEnter({
    required this.name,
    required this.date,
    required this.description,
    required this.time,
  });
  @override
  List<Object> get props => [name, date, description, time];
}

class StepTwoEnter extends CreateEventEvent {
  final String numberOfPeople;
  final String cost;
  final String address;

  const StepTwoEnter({
    required this.numberOfPeople,
    required this.cost,
    required this.address,
  });
  @override
  List<Object> get props => [numberOfPeople, cost, address];
}

class CreateEvent extends CreateEventEvent {}
