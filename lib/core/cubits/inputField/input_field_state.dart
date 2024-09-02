part of 'input_field_cubit.dart';

class InputFieldState extends Equatable {
  final bool hasText;
  final bool isPasswordVisible;

  const InputFieldState({this.hasText = false, this.isPasswordVisible = false});

  InputFieldState copyWith({bool? hasText, bool? isPasswordVisible}) {
    return InputFieldState(
      hasText: hasText ?? this.hasText,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
  @override
  List<Object> get props => [hasText, isPasswordVisible];
}