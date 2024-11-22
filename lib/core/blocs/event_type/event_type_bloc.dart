import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/core/data/repositories/repositories.dart';
import 'package:yourevent/features/features.dart';

part 'event_type_event.dart';
part 'event_type_state.dart';

class EventTypeBloc extends Bloc<EventTypeEvent, EventTypeState> {
  final IEventRepository _eventRepository;

  EventTypeBloc(this._eventRepository) : super(EventTypeInitial()) {
    on<LoadEvent>(_onGetList);
  }

  FutureOr<void> _onGetList(
      LoadEvent event, Emitter<EventTypeState> emit) async {
    try {
      if (state is! EventTypesLoaded) {
        emit(EventTypesLoading());
      }
      final list = await _eventRepository.getListEventType();
      emit(EventTypesLoaded(list: list));
    } catch (e) {
      emit(EventTypesError(error: e));
    } finally {
      event.completer?.complete();
    }
  }
}
