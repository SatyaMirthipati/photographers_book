import 'package:intl/intl.dart';
import 'package:photographers_book/data/network/api_client.dart';
import 'package:photographers_book/model/event.dart';

import '../data/network/api_endpoints.dart';
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

  Future<List<Event>> getEvents({query}) async {
    var response = await apiClient.get(
      '${Api.bookings}/${Api.events}',
      query: query,
    );
    var list = response['data'] as List;
    return list.map((e) => Event.fromMap(e)).toList();
  }

  Future<List<Event>> getMonthlyEvents() async {
    var response = await apiClient.get(
      '${Api.bookings}/${Api.monthlyEvents}',
      query: {'month': DateFormat('yyyy-MM').format(DateTime.now())},
    );
    var list = response['data'] as List;
    print('Data34$list');
    return list.map((e) => Event.fromMap(e)).toList();
  }
}
