import 'package:flutter/material.dart';

import '../model/booking.dart';
import '../model/category.dart';
import '../model/event.dart';
import '../repository/booking_repo.dart';

class BookingBloc with ChangeNotifier {
  final _bookingRepo = BookingRepo();

  Set<Map<String, dynamic>> eventsData = {};
  Set<Map<String, dynamic>> albumData = {};

  Future<List<Category>> getCategories({query}) async {
    return await _bookingRepo.getCategories(query: query);
  }

  Future createBooking({required body}) async {
    return await _bookingRepo.createBooking(body: body);
  }

  Future<List<Booking>> getAllBookings({query}) async {
    return await _bookingRepo.getAllBookings(query: query);
  }

  Future<Booking> getOneBooking({required String id}) async {
    return await _bookingRepo.getOneBooking(id: id);
  }

  // Events
  Future<List<Event>> getEvents({query}) async {
    return await _bookingRepo.getEvents(query: query);
  }

  Future<List<Event>> getMonthlyEvents() async {
    return await _bookingRepo.getMonthlyEvents();
  }
}
