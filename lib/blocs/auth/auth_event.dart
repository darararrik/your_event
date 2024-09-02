
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
  final String name;
  final String password;

  const SignInRequested(this.email, this.password, this.name);

  @override
  List<Object?> get props => [email, password, name];
}

class SignOutRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthSignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthSignUpRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}
