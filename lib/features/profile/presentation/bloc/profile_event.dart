// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {}

class ProfileNewNameRequested extends ProfileEvent {
  final String name;
  const ProfileNewNameRequested({
    required this.name,
  });
  @override
  List<Object> get props => [name];
}
