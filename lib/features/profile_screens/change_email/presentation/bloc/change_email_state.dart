part of 'change_email_bloc.dart';

sealed class ChangeEmailState extends Equatable {
  const ChangeEmailState();

  @override
  List<Object> get props => [];
}

final class ChangeEmailInitial extends ChangeEmailState {}

final class ChangeEmailSuccess extends ChangeEmailState {}

final class ChangeEmailError extends ChangeEmailState {
  final Object error;
  const ChangeEmailError({required this.error});
  @override
  List<Object> get props => [error];
}

final class Loading extends ChangeEmailState {}
