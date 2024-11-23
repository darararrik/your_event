part of 'change_name_bloc.dart';

sealed class ChangeNameState extends Equatable {
  const ChangeNameState();

  @override
  List<Object> get props => [];
}

final class ChangeNameInitial extends ChangeNameState {}



final class Loading extends ChangeNameState {}

final class NameUpdated extends ChangeNameState {
  final UserDto user;
  const NameUpdated({required this.user});
  @override
  List<Object> get props => [user];
}

final class Error extends ChangeNameState {
  final Object error;
  const Error({required this.error});
  @override
  List<Object> get props => [error];
}
