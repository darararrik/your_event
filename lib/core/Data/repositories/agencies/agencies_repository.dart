import 'package:yourevent/core/data/api/api_service.dart';
import 'package:yourevent/core/data/repositories/models/agency/agency_dto.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/core/data/repositories/repositories.dart';

class AgenciesRepository implements IAgenciesRepository {
  final ApiService apiService;

  AgenciesRepository({required this.apiService});

  @override
  Future<List<AgencyDto>> getListAgencies(int pageIndex) {
    return apiService.getListAgencies(pageIndex);
  }

  @override
  Future<List<AgencyServiceDto>> getListAgencyServicesById(int id) {
    return apiService.getListAgencyServicesById(id);
  }

  @override
  Future<void> addServicesToEvent(
      {required String eventId, required List<String> serviceIds}) {
    // TODO: implement addServicesToEvent
    throw UnimplementedError();
  }

  @override
  Future<List<AgencyServiceDto>> getAllAgencyServices() {
    return apiService.getAllAgencyServices();
  }
}
