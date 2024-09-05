part of 'nav_bar_bloc.dart';

sealed class NavBarState extends Equatable {
  const NavBarState();
  
  @override
  List<Object> get props => [];
}

final class NavBarInitial extends NavBarState {}
