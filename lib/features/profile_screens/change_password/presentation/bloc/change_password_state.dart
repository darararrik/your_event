part of 'change_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordError extends ChangePasswordState {
  final Object error;

  const ChangePasswordError({required this.error});
  @override
  List<Object> get props => [error];
}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class Loading extends ChangePasswordState {}
