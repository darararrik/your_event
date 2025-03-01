import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_bar_chat_event.dart';
part 'tab_bar_chat_state.dart';

class TabBarChatBloc extends Bloc<TabBarChatEvent, TabBarChatState> {
  TabBarChatBloc() : super(TabBarChatInitial()) {
    on<TabChanged>(_onTabChanged);
  }

  void _onTabChanged(TabChanged event, Emitter<TabBarChatState> emit) {
    emit(TabBarChatUpdated(tabIndex: event.index));
  }
}
