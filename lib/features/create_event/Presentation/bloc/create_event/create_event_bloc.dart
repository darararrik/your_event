import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yourevent/core/data/models/event_model.dart';
import 'package:yourevent/features/features.dart';

import '../../../../../core/data/repositories/event/event.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final EventRepository _eventRepository;

  CreateEventBloc(this._eventRepository) : super(CreateEventInitial()) {
    on<EventTypesLoad>(_onEventTypesLoad);
    on<CreateEvent>(_onCreateEvent);
  }

  Future<void> _onCreateEvent(event, emit) async {
    try {
      emit(Loading());
      await _eventRepository.pushEventFirebase(event.event);
      emit(EventCreated(event.event));
    } on Exception catch (e) {
      emit(Error(error: e));
    }
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
      emit(Error(error: e.toString()));
    } finally {
      event.completer?.complete();
    }
  }


}
