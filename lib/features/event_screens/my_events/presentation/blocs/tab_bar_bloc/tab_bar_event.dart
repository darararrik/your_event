// tab_bar_event.dart

part of 'tab_bar_bloc.dart';

abstract class TabBarEventEvent extends Equatable {
  const TabBarEventEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends TabBarEventEvent {
  final int index;
  
  const TabChanged({required this.index});
  
  @override
  List<Object> get props => [index];
}
