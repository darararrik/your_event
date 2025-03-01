// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_type_bloc.dart';

sealed class EventTypeEvent extends Equatable {
  const EventTypeEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends EventTypeEvent {
  final Completer? completer;
  const LoadEvent({
    this.completer,
  });
}
