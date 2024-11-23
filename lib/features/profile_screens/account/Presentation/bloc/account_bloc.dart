// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yourevent/core/core.dart';

import 'package:yourevent/core/data/repositories/auth/auth_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository _userRepository;
  AccountBloc(this._userRepository) : super(AccountInitial()) {
    on<AccountUpdateName>(_onUpdateName);
    on<AccountUpdateEmail>(_onUpdateEmail);
  }

  FutureOr<void> _onUpdateName(
      AccountUpdateName event, Emitter<AccountState> emit) async {
    try {
      await _userRepository.updateName(
          name: event.name, surname: event.surname);
      emit(AccountNameUpdated());
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }

  Future<void> _onUpdateEmail(
      AccountUpdateEmail event, Emitter<AccountState> emit) async {
    try {
      await _userRepository.updateEmail(password: event.password);
      emit(AccountEmailUpdated());
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }
}
