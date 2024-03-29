import 'package:flutter/material.dart';

import '../model/booking.dart';
import '../model/booking_payments.dart';
import '../model/booking_sheet.dart';
import '../model/category.dart';
import '../model/due_list.dart';
import '../repository/booking_repo.dart';

class BookingBloc with ChangeNotifier {
  final _bookingRepo = BookingRepo();

  Set<Map<String, dynamic>> eventsData = {};
  Set<Map<String, dynamic>> albumData = {};

  List<BookingsEvents> updateEventsData = [];
  List<BookingsSheets> updateSheetsData = [];

  Future<List<Category>> getCategories({query}) async {
    return await _bookingRepo.getCategories(query: query);
  }

  Future createBooking({required body}) async {
    var response = await _bookingRepo.createBooking(body: body);
    eventsData.clear();
    albumData.clear();
    return response;
  }

  Future<List<Booking>> getAllBookings({query}) async {
    return await _bookingRepo.getAllBookings(query: query);
  }

  Future<Booking> getOneBooking({required String id}) async {
    return await _bookingRepo.getOneBooking(id: id);
  }

  Future<List<BookingSheet>> getBookingAlbums({required String id}) async {
    return await _bookingRepo.getBookingAlbums(id: id);
  }

  Future<List<DueList>> getDueList({required query}) async {
    return await _bookingRepo.getDueList(query: query);
  }

  Future<List<BookingPayments>> getBookingPayments({query}) async {
    return await _bookingRepo.getBookingPayments(query: query);
  }

  Future makePayment({body}) async {
    return await _bookingRepo.makePayment(body: body);
  }
}
