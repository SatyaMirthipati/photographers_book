import '../data/network/api_client.dart';
import '../data/network/api_endpoints.dart';
import '../model/profile.dart';

class UserRepo {
  Future login({required Map<String, String> body}) async {
    var response = await apiClient.post(
      Api.login,
      body,
    );
    return response;
  }

  Future<Profile> getProfile() async {
    var response = await apiClient.get('${Api.users}/${Api.profile}');
    return Profile.fromMap(response);
  }

  Future registerUser({required body}) async {
    var response = await apiClient.post(Api.users, body);
    return response;
  }

  Future requestOtp({required body}) async {
    var response = await apiClient.post(Api.requestOtp, body);
    return response;
  }

  Future verifyOtp({required body}) async {
    var response = await apiClient.post(Api.verifyOtp, body);
    return response;
  }

  Future passwordChange({required body}) async {
    var response = await apiClient.post(Api.changePassword, body);
    return response;
  }
}
