import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/features/features.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final EventRepository _eventRepository;

  CreateEventBloc(this._eventRepository) : super(CreateEventInitial()) {
    on<EventTypesLoad>(_onEventTypesLoad);
    add(const EventTypesLoad(completer: null));
    on<StepOneEnter>(_onStepOneEnter);
    on<StepTwoEnter>(_onStepTwoEnter);

    on<CreateEvent>(_onCreateEvent);
  }

  Future<void> _onCreateEvent(event, emit) async {
    final currentState = state;
    if (currentState is StepTwoComplete) {
      final eventData = currentState.event;
      await _eventRepository.pushEventFirebase(eventData);
      emit(EventCreated(eventData));
    }
  }

  void _onStepOneEnter(StepOneEnter event, Emitter<CreateEventState> emit) {
    final eventData = EventModel(
      name: event.name,
      date: event.date,
      description: event.description,
      time: event.time,
    );
    emit(StepOneComplete(eventData));
  }

  void _onStepTwoEnter(StepTwoEnter event, Emitter<CreateEventState> emit) {
    emit(Loading());
    EventModel eventData = event.event;
    eventData.cost = event.cost;
    eventData.address = event.address;
    eventData.numberOfPeople = event.numberOfPeople;
    emit(StepTwoComplete(eventData));
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
