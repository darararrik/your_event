part of 'service_bloc.dart';

sealed class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

final class ServiceInitial extends ServiceState {}

class ServicesLoading extends ServiceState {}

class ServicesLoaded extends ServiceState {
  final List<AgencyServiceDto> services;
  final String sortingMethod;
  const ServicesLoaded(this.services, {this.sortingMethod = "По умолчанию"});
  @override
  List<Object> get props => [services, sortingMethod];
}

class ServicesError extends ServiceState {
  final String error;

  const ServicesError(this.error);
}
