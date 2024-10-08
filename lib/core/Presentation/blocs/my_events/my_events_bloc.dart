import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/features/create_event/Data/repository/event_repository.dart';
import 'package:yourevent/features/create_event/models/event_model.dart';

part 'my_events_event.dart';
part 'my_events_state.dart';

class MyEventsBloc extends Bloc<MyEventsEvent, MyEventsState> {
  final EventRepository _eventRepository;

  MyEventsBloc(this._eventRepository) : super(MyEventsInitial()) {
    on<MyEventsLoad>(_onLoadEvents);
  }
  Future<void> _onLoadEvents(
      MyEventsLoad event, Emitter<MyEventsState> emit) async {
    try {
      if (state is! MyEventsLoaded) {
        emit(MyEventsLoading());
      }
      final events = await _eventRepository.fetchEvents();
      emit(MyEventsLoaded(list: events));
    } catch (e) {
      emit(MyEventsError(error: e.toString()));
    } finally {
      event.completer?.complete();
    }
  }
}
