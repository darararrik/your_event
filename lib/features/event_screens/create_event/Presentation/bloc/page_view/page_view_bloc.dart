import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_view_event.dart';
part 'page_view_state.dart';

class PageViewBloc extends Bloc<PageViewEvent, PageViewState> {
  PageViewBloc() : super(PageViewInitial()) {
    on<PageViewChanged>((event, emit) {
      emit(PageViewUpdated(pageIndex: event.index));
    });
  }
}

// tab_bar_bloc.dart

