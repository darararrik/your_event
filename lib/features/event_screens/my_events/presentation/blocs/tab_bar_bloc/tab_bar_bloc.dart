
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_bar_event.dart';
part 'tab_bar_state.dart';

class TabBarEventBloc extends Bloc<TabBarEventEvent, TabBarEventState> {
  TabBarEventBloc() : super(TabBarEventInitial()) {
    on<TabChanged>(_onTabChanged);
  }

  void _onTabChanged(TabChanged event, Emitter<TabBarEventState> emit) {
    emit(TabBarEventUpdated(tabIndex: event.index));
  }
}