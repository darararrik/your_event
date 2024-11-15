import 'package:yourevent/core/Data/repositories/repositories.dart';

abstract interface class IEventRepository {
  Future<List<EventTypeModel>> getListEventType();

  Future<List<EventModel>> getListEvents();

  Future<void> createEvent(EventModel eventData);

  checkDates(List<EventModel> events);
}
