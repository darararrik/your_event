part of 'change_name_bloc.dart';

sealed class ChangeNameEvent extends Equatable {
  const ChangeNameEvent();

  @override
  List<Object> get props => [];
}

class AccountUpdateName extends ChangeNameEvent {
  final String name;
  final String surname;

  const AccountUpdateName({
    required this.name,
    required this.surname,
  });
  @override
  List<Object> get props => [name, surname];
}
