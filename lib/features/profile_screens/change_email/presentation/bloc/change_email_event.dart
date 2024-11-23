part of 'change_email_bloc.dart';

sealed class ChangeEmailEvent extends Equatable {
  const ChangeEmailEvent();

  @override
  List<Object> get props => [];
}

final class AccountUpdateEmail extends ChangeEmailEvent {
  final String email;
  const AccountUpdateEmail({required this.email});
  @override
  List<Object> get props => [email];
}

final class ResetState extends ChangeEmailEvent {}
