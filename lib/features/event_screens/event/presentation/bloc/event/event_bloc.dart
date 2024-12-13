import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/core/core.dart';
import 'package:yourevent/core/data/repositories/agencies/agencies_repository.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<AddServiceEvent>(_onAddServiceeToEvent);
  }

  FutureOr<void> _onAddServiceeToEvent(
      AddServiceEvent event, Emitter<EventState> emit) {
    // Получаем текущий список услуг
    final updatedServices = List<AgencyServiceDto>.from(
        state is EventServiceAdded ? (state as EventServiceAdded).services : [])
      ..add(event.service);

    // Группируем услуги по агентствам
    final groupedServices = <String, List<AgencyServiceDto>>{};
    for (var service in updatedServices) {
      final agencyName =
          service.agencyName; // Поле agencyName у AgencyServiceDto
      if (groupedServices.containsKey(agencyName)) {
        groupedServices[agencyName]!.add(service);
      } else {
        groupedServices[agencyName] = [service];
      }
    }

    // Эмитим новое состояние с обновленными данными
    emit(EventServiceAdded(
      services: updatedServices,
      groupedServices: groupedServices,
    ));
  }
}
