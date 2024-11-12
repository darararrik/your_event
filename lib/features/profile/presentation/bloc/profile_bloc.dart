import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/repositories/auth/auth.dart';
import 'package:yourevent/core/data/repositories/models/user_dto/user_dto.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthRepository authRepository;
  ProfileBloc(this.authRepository) : super(ProfileLoading()) {
    on<ProfileLoadRequested>(_onProfileLoad);
  }

  Future<void> _onProfileLoad(
      ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      //final firebaseUser = await authRepository.getCurrentUser();
      //final user = user_model.User.fromFirebaseUser(firebaseUser!);
      //emit(ProfileLoaded(user: user));
    } catch (e) {
      emit(ProfileError(error: e));
    }
  }
}
