part of 'my_events_bloc.dart';

sealed class MyEventsState extends Equatable {
  const MyEventsState();

  @override
  List<Object> get props => [];
}

final class MyEventsInitial extends MyEventsState {}

final class MyEventsLoaded extends MyEventsState {
  final List<EventModel> list;
  const MyEventsLoaded({required this.list});

  @override
  List<Object> get props => [list];
}

class MyEventsError extends MyEventsState {
  final Object error;

  const MyEventsError({required this.error});
  @override
  List<Object> get props => [error];
}

final class MyEventsLoading extends MyEventsState {}

final class MyEventsLoadedCompleted extends MyEventsState {
  final List<EventModel> list;

  const MyEventsLoadedCompleted({required this.list});
}

final class MyEventsLoadedCreated extends MyEventsState {
  final List<EventModel> list;

  const MyEventsLoadedCreated({required this.list});
}
