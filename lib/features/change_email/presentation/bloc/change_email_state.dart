part of 'change_email_bloc.dart';

sealed class ChangeEmailState extends Equatable {
  const ChangeEmailState();

  @override
  List<Object> get props => [];
}

final class ChangeEmailInitial extends ChangeEmailState {}

final class EmailUpdated extends ChangeEmailState {}

final class Loading extends ChangeEmailState {}

final class Error extends ChangeEmailState {
  final Object error;
  const Error({required this.error});
  @override
  List<Object> get props => [error];
}
