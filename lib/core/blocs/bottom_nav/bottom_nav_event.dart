part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}

class BottomNavIndexChanged extends BottomNavEvent {
  final int index;

  BottomNavIndexChanged(this.index);
  @override
  List<Object> get props => [index];
}