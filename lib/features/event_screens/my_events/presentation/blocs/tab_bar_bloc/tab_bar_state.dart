// tab_bar_state.dart

part of 'tab_bar_bloc.dart';

abstract class TabBarEventState extends Equatable {
  const TabBarEventState();

  @override
  List<Object> get props => [];
}

class TabBarEventInitial extends TabBarEventState {}

class TabBarEventUpdated extends TabBarEventState {
  final int tabIndex;

  const TabBarEventUpdated({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}
