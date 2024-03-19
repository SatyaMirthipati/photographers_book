import 'package:flutter/material.dart';

import '../model/event.dart';
import '../repository/event_repo.dart';

class EventBloc with ChangeNotifier {
  final _eventRepo = EventRepo();

  Future<List<Event>> getEvents({query}) async {
    return await _eventRepo.getEvents(query: query);
  }

  Future<List<Event>> getMonthlyEvents() async {
    return await _eventRepo.getMonthlyEvents();
  }

  Future<Event> getOneEvent({required String id}) async {
    return await _eventRepo.getOneEvent(id: id);
  }

  Future<List<Event>> getBookingEvents({required String id}) async {
    return await _eventRepo.getBookingEvents(id: id);
  }

  Future updateEvent({required String id, required body}) async {
    return await _eventRepo.updateEvent(id: id, body: body);
  }
}
