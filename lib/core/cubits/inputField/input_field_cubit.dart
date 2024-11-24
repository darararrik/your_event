import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'input_field_state.dart';
class InputFieldCubit extends Cubit<InputFieldState> {
  InputFieldCubit() : super(const InputFieldState());

  void textChanged(String text) {
    emit(state.copyWith(hasText: text.isNotEmpty));
  }

  void clearText() {
    emit(state.copyWith(hasText: false));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }
}