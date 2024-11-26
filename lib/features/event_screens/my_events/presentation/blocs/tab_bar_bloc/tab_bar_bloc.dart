
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_bar_event.dart';
part 'tab_bar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  TabBarBloc() : super(TabBarInitial()) {
    on<TabChanged>(_onTabChanged);
  }

  void _onTabChanged(TabChanged event, Emitter<TabBarState> emit) {
    emit(TabBarUpdated(tabIndex: event.index));
  }
}