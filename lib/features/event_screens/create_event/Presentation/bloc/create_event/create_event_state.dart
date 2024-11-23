// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_event_bloc.dart';

sealed class CreateEventState extends Equatable {
  const CreateEventState();

  @override
  List<Object> get props => [];
}

final class CreateEventInitial extends CreateEventState {}

class CreateEventSuccess extends CreateEventState {}

class CreateEventLoadingState extends CreateEventState {}

class CreateEventErrorState extends CreateEventState {
  final Object error;
  const CreateEventErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
