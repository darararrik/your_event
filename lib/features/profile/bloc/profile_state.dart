part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final user_model.User user;
  const ProfileLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class ProfileError extends ProfileState {
  final Object _error;
  const ProfileError({required Object error}) : _error = error;
  @override
  List<Object> get props => [_error];
}
