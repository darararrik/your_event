part of 'create_event_bloc.dart';

sealed class CreateEventState extends Equatable {
  const CreateEventState();
  
  @override
  List<Object> get props => [];
}

final class CreateEventInitial extends CreateEventState {}
