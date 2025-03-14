part of 'service_bloc.dart';

sealed class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

class LoadServices extends ServiceEvent {}

class SortServicesAscending extends ServiceEvent {}

class SortServicesDescending extends ServiceEvent {}
