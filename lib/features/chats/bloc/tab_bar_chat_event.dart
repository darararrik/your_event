// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tab_bar_chat_bloc.dart';

sealed class TabBarChatEvent extends Equatable {
  const TabBarChatEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends TabBarChatEvent {
  final int index;
  const TabChanged({
    required this.index,
  });
  @override
  List<Object> get props => [index];
}
