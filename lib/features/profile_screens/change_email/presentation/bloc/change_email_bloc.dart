import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/core/data/repositories/user/user_repository.dart';

part 'change_email_event.dart';
part 'change_email_state.dart';

class ChangeEmailBloc extends Bloc<ChangeEmailEvent, ChangeEmailState> {
  final UserRepository _userRepository;

  ChangeEmailBloc(this._userRepository) : super(ChangeEmailInitial()) {
    on<AccountUpdateEmail>(_onUpdateEmail);
    on<ResetState>((event, emit) => emit(ChangeEmailInitial()));
  }

  Future<void> _onUpdateEmail(
      AccountUpdateEmail event, Emitter<ChangeEmailState> emit) async {
    try {
      await _userRepository.updateEmail(newEmail: event.email);
      emit(EmailUpdated());
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }
}
