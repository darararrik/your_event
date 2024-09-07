part of 'bottom_nav_bloc.dart';

abstract class BottomNavState extends Equatable {
  const BottomNavState();
  
  @override
  List<Object> get props => [];
}

class BottomNavInitial extends BottomNavState {
  final int currentIndex;

  const BottomNavInitial(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}




