part of 'page_view_bloc.dart';

sealed class PageViewEvent extends Equatable {
  const PageViewEvent();

  @override
  List<Object> get props => [];
}


class PageViewChanged extends PageViewEvent {
  final int index;
  
  const PageViewChanged({required this.index});
  
  @override
  List<Object> get props => [index];
}
