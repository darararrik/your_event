part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthCheckRequested extends AuthEvent {
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
  final String password;

  const SignUpRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}
class EmailChanged extends AuthEvent {
  final String email;

  EmailChanged(this.email);
  
  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends AuthEvent {
  final String password;

  PasswordChanged(this.password);
  
  @override
  List<Object?> get props => [password];
}
