import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/features/features.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final EventRepository _eventRepository;

  CreateEventBloc(this._eventRepository) : super(CreateEventInitial()) {
    on<EventTypesLoad>(_onEventTypesLoad);
    add(const EventTypesLoad(completer: null));
  }

  Future<void> _onEventTypesLoad(
    EventTypesLoad event,
    Emitter<CreateEventState> emit,
  ) async {
    try {
      if (state is! EventTypesLoaded) {
        emit(EventTypesLoading());
      }
      final eventTypes = await _eventRepository.fetchEventTypesModel();
      emit(EventTypesLoaded(
        list: eventTypes,
      ));
    } catch (e) {
      emit(EventTypesError(error: e.toString()));
    } finally {
      event.completer?.complete();
    }
  }
}
