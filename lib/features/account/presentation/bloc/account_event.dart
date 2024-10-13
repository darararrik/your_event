part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

final class AccountUpdateEmail extends AccountEvent {
  final String email;
  final String password;
  const AccountUpdateEmail({required this.email, required this.password});
}

final class AccountUpdatePassword extends AccountEvent {
  const AccountUpdatePassword();
}

class AccountUpdateName extends AccountEvent {
  final String name;
  const AccountUpdateName({required this.name});
}

final class AccountUpdate extends AccountEvent {
  const AccountUpdate();
}
