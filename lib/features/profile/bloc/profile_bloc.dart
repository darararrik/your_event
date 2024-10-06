import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:yourevent/core/Domain/models/user_model.dart' as user_model;
import 'package:yourevent/core/Data/repositories/auth/auth_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthRepository authRepository;
  ProfileBloc(this.authRepository) : super(ProfileLoading()) {
    on<ProfileLoadRequested>(_onProfileLoad);
    add(ProfileLoadRequested());
  }

  Future<void> _onProfileLoad(
      ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    try {
      if (state is! ProfileLoaded) {
        emit(ProfileLoading());
      }
      final firebaseUser = await authRepository.getCurrentUser();
      final user = user_model.User.fromFirebaseUser(firebaseUser!);
      emit(ProfileLoaded(user: user));
    } catch (e) {
      emit(ProfileError(error: e));
    }
  }
}
