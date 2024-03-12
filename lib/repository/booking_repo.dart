import '../data/network/api_client.dart';
import '../data/network/api_endpoints.dart';
import '../model/booking.dart';
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
}
