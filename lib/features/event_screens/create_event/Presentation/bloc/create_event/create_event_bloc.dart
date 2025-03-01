import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/core/data/api/api_service.dart';
import 'package:yourevent/core/data/repositories/event/event_interface_repository.dart';
import 'package:yourevent/core/data/repositories/models/event/event_dto.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final IEventRepository eventRepository;
  final ApiService apiService;

  CreateEventBloc({
    required this.eventRepository,
    required this.apiService,
  }) : super(CreateEventInitial()) {
    on<SubmitEvent>(_onSubmitEvent);
    on<ResetEvent>(_onResetEventState);
  }

  Future<void> _onSubmitEvent(
    SubmitEvent event,
    Emitter<CreateEventState> emit,
  ) async {
    try {
      if (state is! CreateEventSuccess) {
        emit(CreateEventLoadingState());
      }
      final user = await apiService.getCurrentUser();
      final eventDto = EventDto(
          name: event.name,
          price: event.price,
          categoryId: event.categoryId,
          startDate: event.startDate,
          endDate: event.endDate,
          address: event.address,
          description: event.description,
          userId: user.id,
          people: event.people);
      await eventRepository.createEvent(eventDto);
      emit(CreateEventSuccess());
    } catch (e) {
      emit(CreateEventErrorState(error: e));
    }
  }

  void _onResetEventState(ResetEvent event, Emitter<CreateEventState> emit) {
    emit(CreateEventInitial());
  }
}
