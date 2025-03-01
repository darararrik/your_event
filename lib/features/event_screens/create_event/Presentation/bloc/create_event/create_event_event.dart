part of 'create_event_bloc.dart';

abstract class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override
  List<Object?> get props => [];
}

// Событие для отправки данных мероприятия
class SubmitEvent extends CreateEventEvent {
  final String name;
  final int price;
  final int categoryId;
  final DateTime startDate;
  final DateTime endDate;
  final String address;
  final String description;
  final int people;

  const SubmitEvent({
    required this.name,
    required this.price,
    required this.categoryId,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.description,
    required this.people,
  });

  @override
  List<Object?> get props => [
        name,
        price,
        categoryId,
        startDate,
        endDate,
        address,
        description,
        people,
      ];
}

class ResetEvent extends CreateEventEvent {}
