import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/core/data/models/models.dart';
import 'package:yourevent/core/data/repositories/event/event.dart';

part 'my_events_event.dart';
part 'my_events_state.dart';

class MyEventsBloc extends Bloc<MyEventsEvent, MyEventsState> {
  final EventRepository _eventRepository;

  MyEventsBloc(this._eventRepository) : super(MyEventsInitial()) {
    on<MyEventsLoad>(_onLoadEvents);
    // Удаляем отдельные обработчики для завершенных и созданных событий
  }

  Future<void> _onLoadEvents(
      MyEventsLoad event, Emitter<MyEventsState> emit) async {
    try {
      if (state is! MyEventsLoaded) {
        emit(MyEventsLoading());
      }
      List<EventModel> events = await _eventRepository.fetchEvents();
      await _eventRepository.checkDates(events);
      events = await _eventRepository.fetchEvents();
      emit(MyEventsLoaded(list: events));
    } catch (e) {
      emit(MyEventsError(error: e.toString()));
    } finally {
      event.completer?.complete();
    }
  }
}
