import 'package:yourevent/core/data/repositories/repositories.dart';

abstract interface class IEventRepository {
  Future<List<EventTypeDto>> getListEventType();

  Future<List<EventDto>> getListEvents(int userId);

  Future<void> createEvent(EventDto eventData);


}
