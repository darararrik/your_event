part of 'account_bloc.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

final class AccountInitial extends AccountState {}

final class AccountEmailUpdated extends AccountState {}

final class AccountPasswordUpdated extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountNameUpdated extends AccountState {
  final UserDto user;
  const AccountNameUpdated({required this.user});
  @override
  List<Object> get props => [user];
}

final class Error extends AccountState {
  final Object error;
  const Error({required this.error});
  @override
  List<Object> get props => [error];
}
