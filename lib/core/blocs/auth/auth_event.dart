part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

final class CheckLoginStatus extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignInGoogleRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInGoogleRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String surname;

  final String password;

  const SignUpRequested({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, surname, email, password];
}
