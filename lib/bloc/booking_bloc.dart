import 'package:flutter/material.dart';
import 'package:photographers_book/repository/booking_repo.dart';

import '../model/category.dart';

class BookingBloc with ChangeNotifier {
  final _bookingRepo = BookingRepo();

  Future<List<Category>> getCategories({query}) async {
    return await _bookingRepo.getCategories(query: query);
  }
}
