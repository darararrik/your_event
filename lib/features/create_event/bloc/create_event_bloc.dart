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
    on<StepOneEnter>(_stepOneEnter);
    on<StepTwoEnter>(_stepTwoEnter);

    on<CreateEvent>((event, emit) async {
      final currentState = state;
      if (currentState is StepTwoComplete) {
        final eventData = currentState.event;
        await _eventRepository.pushEventFirebase(eventData);
        emit(EventCreated(eventData));
      }
    });
  }

  FutureOr<void> _stepTwoEnter(event, emit) {
    final currentState = state;
    if (currentState is StepOneComplete) {
      final eventData = currentState.event
        .numberOfPeople = event.numberOfPeople
        .cost = event.cost
        .address = event.address;
  
      emit(StepTwoComplete(eventData));
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
      emit(EventTypesError(error: e.toString()));
    } finally {
      event.completer?.complete();
    }
  }

  void _stepOneEnter(StepOneEnter event, Emitter<CreateEventState> emit) {
    final eventData = EventModel(
      name: event.name,
      date: event.date,
      description: event.description,
      time: event.time,
    );
    emit(StepOneComplete(eventData));
  }
}
