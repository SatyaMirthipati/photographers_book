import 'package:intl/intl.dart';

import '../data/network/api_client.dart';
import '../data/network/api_endpoints.dart';
import '../model/event.dart';

class EventRepo {
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
    return list.map((e) => Event.fromMap(e)).toList();
  }

  Future<Event> getOneEvent({required String id}) async {
    var response = await apiClient.get('${Api.bookings}/${Api.events}/$id');
    return Event.fromMap(response);
  }

  Future<List<Event>> getBookingEvents({query}) async {
    var response = await apiClient.get(
      '${Api.bookings}/${Api.bookingEvents}',
      query: query,
    );
    var list = response['data'] as List;
    return list.map((e) => Event.fromMap(e)).toList();
  }
}
