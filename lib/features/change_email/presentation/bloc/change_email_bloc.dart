// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:yourevent/core/data/repositories/auth/auth.dart';

part 'change_email_event.dart';
part 'change_email_state.dart';

class ChangeEmailBloc extends Bloc<ChangeEmailEvent, ChangeEmailState> {
  AuthRepository authRepository;

  ChangeEmailBloc(
    this.authRepository,
  ) : super(ChangeEmailInitial()) {

    on<RequestedUpdateEmailEvent>(_onProfileUpdateEmail);
  }
  Future<void> _onProfileUpdateEmail(
      RequestedUpdateEmailEvent event, Emitter<ChangeEmailState> emit) async {
    try {
      emit(Loading());
      await authRepository.updateEmail(
          email: event.email, currentPassword: event.password);

      emit(EmailUpdated());
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }
}
