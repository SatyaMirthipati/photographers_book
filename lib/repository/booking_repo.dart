import 'package:photographers_book/model/due_list.dart';

import '../data/network/api_client.dart';
import '../data/network/api_endpoints.dart';
import '../model/booking.dart';
import '../model/booking_payments.dart';
import '../model/booking_sheet.dart';
import '../model/category.dart';

class BookingRepo {
  Future<List<Category>> getCategories({query}) async {
    var response = await apiClient.get(Api.categories, query: query);
    var list = response['data'] as List;
    return list.map((e) => Category.fromMap(e)).toList();
  }

  Future createBooking({required body}) async {
    var response = await apiClient.post(Api.bookings, body);
    return response;
  }

  Future<List<Booking>> getAllBookings({query}) async {
    var response = await apiClient.get(Api.bookings, query: query);
    var list = response['data'] as List;
    return list.map((e) => Booking.fromMap(e)).toList();
  }

  Future<Booking> getOneBooking({required String id}) async {
    var response = await apiClient.get('${Api.bookings}/$id');
    return Booking.fromMap(response);
  }

  Future<List<BookingSheet>> getBookingAlbums({required String id}) async {
    var response = await apiClient.get(
      '${Api.bookings}/${Api.bookingSheets}/$id',
    );
    var list = response['data'] as List;
    return list.map((e) => BookingSheet.fromMap(e)).toList();
  }

  Future<List<DueList>> getDueList({required query}) async {
    var response = await apiClient.get(
      '${Api.bookings}/${Api.duelist}',
      query: query,
    );
    var list = response['data'] as List;
    return list.map((e) => DueList.fromMap(e)).toList();
  }

  Future editBooking({required String id, required body}) async {
    var response = await apiClient.patch('${Api.bookings}/$id', body);
    return response;
  }

  Future completeBooking({required String id}) async {
    var response = await apiClient.patch(
      '${Api.bookings}/${Api.bookingStatus}/$id',
      {'status': 'COMPLETED'},
    );
    return response;
  }

  //Payments
  Future<List<BookingPayments>> getBookingPayments({query}) async {
    var response = await apiClient.get(Api.bookingPayments, query: query);
    var list = response['data'] as List;
    return list.map((e) => BookingPayments.fromMap(e)).toList();
  }

  Future makePayment({body}) async {
    var response = await apiClient.post(Api.bookingPayments, body);
    return response;
  }
}
