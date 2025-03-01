import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/core/data/repositories/event/event_repository.dart';
import 'package:yourevent/core/data/repositories/models/event/event_dto.dart';
import 'package:yourevent/core/data/repositories/user/user_repository.dart';

part 'my_events_event.dart';
part 'my_events_state.dart';

class MyEventsBloc extends Bloc<MyEventsEvent, MyEventsState> {
  final EventRepository _eventRepository;
  final UserRepository _userRepository;

  MyEventsBloc(this._eventRepository, this._userRepository)
      : super(MyEventsInitial()) {
    on<MyEventsLoad>(_onLoadEvents);
    // Удаляем отдельные обработчики для завершенных и созданных событий
  }

  Future<void> _onLoadEvents(
      MyEventsLoad event, Emitter<MyEventsState> emit) async {
    try {
      if (state is! MyEventsLoaded) {
        emit(MyEventsLoading());
      }
      final user = await _userRepository.getCurrentUser();
      List<EventDto> events = await _eventRepository.getListEvents(user.id);
      if (events.isNotEmpty) {
        emit(MyEventsLoaded(list: events));
      } else {
        emit(MyEventsInitial());
      }
    } catch (e) {
      emit(MyEventsError(error: e.toString()));
    } finally {
      event.completer?.complete();
    }
  }
}
