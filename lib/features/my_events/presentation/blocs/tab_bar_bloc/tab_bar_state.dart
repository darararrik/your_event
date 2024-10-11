// tab_bar_state.dart

part of 'tab_bar_bloc.dart';

abstract class TabBarState extends Equatable {
  const TabBarState();
  
  @override
  List<Object> get props => [];
}

class TabBarInitial extends TabBarState {}

class TabBarUpdated extends TabBarState {
  final int tabIndex;
  
  const TabBarUpdated({required this.tabIndex});
  
  @override
  List<Object> get props => [tabIndex];
}
