part of 'tab_bar_chat_bloc.dart';

sealed class TabBarChatState extends Equatable {
  const TabBarChatState();

  @override
  List<Object> get props => [];
}

final class TabBarChatInitial extends TabBarChatState {}

class TabBarChatUpdated extends TabBarChatState {
  final int tabIndex;

  const TabBarChatUpdated({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}
