part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class Authenticated extends AuthState {
  const Authenticated();
}

class Unauthenticated extends AuthState {}

class AuthErrorState extends AuthState {
  final String? error;

  const AuthErrorState({this.error});
  @override
  List<Object?> get props => [error];
}
