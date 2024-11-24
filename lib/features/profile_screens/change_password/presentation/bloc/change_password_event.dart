part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordRequested extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordRequested(
      {required this.oldPassword, required this.newPassword});

  @override
  List<Object> get props => [oldPassword, newPassword];
}

final class ResetState extends ChangePasswordEvent {}
