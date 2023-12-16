import '../data/network/api_client.dart';
import '../data/network/api_endpoints.dart';

class UserRepo {
  Future login({required Map<String, String> body}) async {
    var response = await apiClient.post(Api.login, body,);
    return response;
  }

  Future getProfile() async {
    var response = await apiClient.get(Api.profile);
    return response;
  }
}
