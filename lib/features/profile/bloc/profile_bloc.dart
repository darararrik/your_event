import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:yourevent/core/models/user_model.dart' as user_model;
import 'package:yourevent/repositories/auth/auth_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthRepository authRepository;
  ProfileBloc(this.authRepository) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      on<ProfileLoadRequested>(_onProfileLoad);
    });
  }

  Future<void> _onProfileLoad(
      ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final firebaseUser = await authRepository.getCurrentUser();
      final user = user_model.User.fromFirebaseUser(firebaseUser!);
      emit(ProfileLoaded(user: user));
    } catch (e) {
      emit(ProfileError(error: e));
    }
  }
}