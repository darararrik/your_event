part of 'change_email_bloc.dart';

sealed class ChangeEmailEvent extends Equatable {
  const ChangeEmailEvent();

  @override
  List<Object> get props => [];
}
class RequestedUpdateEmailEvent extends ChangeEmailEvent {
  final String email;
  final String password;

  const RequestedUpdateEmailEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email];
}

class ProfileUpdatePassword extends ChangeEmailEvent {
  final String password;

  const ProfileUpdatePassword(this.password);
  @override
  List<Object> get props => [password];
}