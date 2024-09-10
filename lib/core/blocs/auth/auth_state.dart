part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
//class AuthChecking extends AuthState {}
class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  final String? emailError;
  final String? passwordError;

  const AuthErrorState({this.emailError, this.passwordError});
  @override
  List<Object?> get props => [];
}
