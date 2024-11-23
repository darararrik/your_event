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
  @override
  List<Object> get props => [email, password];
}

final class AccountUpdatePassword extends AccountEvent {
  const AccountUpdatePassword();
}

class AccountUpdateName extends AccountEvent {
  final String name;
  final String surname;

  const AccountUpdateName({
    required this.name,
    required this.surname,
  });
  @override
  List<Object> get props => [name, surname];
}

final class AccountUpdate extends AccountEvent {
  const AccountUpdate();
}
