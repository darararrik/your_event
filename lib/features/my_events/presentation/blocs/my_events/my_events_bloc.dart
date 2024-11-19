import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/core/Data/repositories/event/event_repository.dart';
import 'package:yourevent/core/Data/repositories/models/eventModel/event_model.dart';

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
        //TODO: нужно начать хранить
      List<EventModel> events = await _eventRepository.getListEvents(18);
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
