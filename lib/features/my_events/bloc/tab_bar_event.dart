// tab_bar_event.dart

part of 'tab_bar_bloc.dart';

abstract class TabBarEvent extends Equatable {
  const TabBarEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends TabBarEvent {
  final int index;
  
  const TabChanged({required this.index});
  
  @override
  List<Object> get props => [index];
}
