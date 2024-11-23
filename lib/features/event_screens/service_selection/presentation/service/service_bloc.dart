import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/core/data/repositories/agencies/agencies_repository.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final AgenciesRepository agenciesRepository;

  ServiceBloc(this.agenciesRepository) : super(ServiceInitial()) {
    on<LoadServices>(_onLoadServices);
  }

  Future<void> _onLoadServices(
      LoadServices event, Emitter<ServiceState> emit) async {
    emit(ServicesLoading());
    try {
      final services = await agenciesRepository.getAllAgencyServices();
      emit(ServicesLoaded(services));
    } catch (e) {
      emit(const ServicesError("Ошибка загрузки услуг"));
    }
  }
}
