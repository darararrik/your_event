import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/core/core.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserRepository _userRepository;
  ChangePasswordBloc(this._userRepository) : super(ChangePasswordInitial()) {
    on<ChangePasswordRequested>(_onChangePassword);
    on<ResetState>((event, emit) => emit(ChangePasswordInitial()));
  }

  FutureOr<void> _onChangePassword(
      ChangePasswordRequested event, Emitter<ChangePasswordState> emit) async {
    try {
      emit(ChangePasswordLoading());
      await _userRepository.updatePassword(
          oldPassword: event.oldPassword, newPassword: event.newPassword);
      emit(ChangePasswordSuccess());
    } catch (e) {
      emit(ChangePasswordError(error: e.toString()));
    }
  }
}
