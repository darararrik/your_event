import 'package:yourevent/core/data/repositories/models/agency/agency_dto.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';

abstract interface class IAgenciesRepository {
  Future<List<AgencyDto>> getListAgencies(int pageIndex);
  Future<List<AgencyServiceDto>> getListAgencyServicesById(int id);
  Future<List<AgencyServiceDto>> getAllAgencyServices();
  Future<void> addServicesToEvent({
    required String eventId,
    required List<String> serviceIds,
  });
}
