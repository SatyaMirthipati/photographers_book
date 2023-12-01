import 'dio_client.dart';

class ApiClient {
  Future get(String path, {query}) async {}

  Future post(String path, body, {query}) async {}

  Future put(String path, body, {query}) async {}

  Future patch(String path, body, {query}) async {}

  Future delete(String path, {body, query}) async {}
}

final apiClient = DioClient();
