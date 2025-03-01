import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/core/core.dart';

part 'change_name_event.dart';
part 'change_name_state.dart';

class ChangeNameBloc extends Bloc<ChangeNameEvent, ChangeNameState> {
  final UserRepository _userRepository;

  ChangeNameBloc(this._userRepository) : super(ChangeNameInitial()) {

    on<AccountUpdateName>(_onUpdateNameAndSurname);
  }
  FutureOr<void> _onUpdateNameAndSurname(
      AccountUpdateName event, Emitter<ChangeNameState> emit) async {
    try {
      final user = await _userRepository.updateName(
          name: event.name, surname: event.surname);
      emit(ChangeNameSuccess(user: user));
    } catch (e) {
      emit(ChangeNameError(error: e.toString()));
    }
  }

 


}
