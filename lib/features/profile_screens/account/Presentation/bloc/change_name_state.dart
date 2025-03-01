part of 'change_name_bloc.dart';

sealed class ChangeNameState extends Equatable {
  const ChangeNameState();

  @override
  List<Object> get props => [];
}

final class ChangeNameInitial extends ChangeNameState {}

final class Loading extends ChangeNameState {}

final class ChangeNameSuccess extends ChangeNameState {
  final UserDto user;
  const ChangeNameSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

final class ChangeNameError extends ChangeNameState {
  final Object error;
  const ChangeNameError({required this.error});
  @override
  List<Object> get props => [error];
}
