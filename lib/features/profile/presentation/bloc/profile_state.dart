part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final user_model.UserEntity user;
  const ProfileLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class ProfileError extends ProfileState {
  final Object error;
  const ProfileError({required this.error});
  @override
  List<Object> get props => [error];
}

class ProfileEmailUpdated extends ProfileState {}
class ProfileNameUpdated extends ProfileState {}
