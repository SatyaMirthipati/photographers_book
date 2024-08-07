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

  Future<Event> getOneEvent({required String id}) async {
    var response = await apiClient.get('${Api.bookings}/${Api.events}/$id');
    var data = response['data'][0];
    return Event.fromMap(data);
  }

  Future updateEvent({required String id, required body}) async {
    var response = await apiClient.patch(
      '${Api.bookings}/${Api.events}/$id',
      body,
    );
    return response;
  }
}
