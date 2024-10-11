part of 'my_events_bloc.dart';

sealed class MyEventsEvent extends Equatable {
  const MyEventsEvent();

  @override
  List<Object> get props => [];
}

class MyEventsLoad extends MyEventsEvent {
  final Completer? completer;
  const MyEventsLoad({
    this.completer,
  });
}

class MyEventsLoadCreated extends MyEventsLoad {
  final List<EventModel>? list;

  const MyEventsLoadCreated(this.list);
}

class MyEventsLoadCompleted extends MyEventsLoad {
  final List<EventModel>? list;

  const MyEventsLoadCompleted(this.list);
}
