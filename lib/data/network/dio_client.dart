import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../local/shared_prefs.dart';
import 'api_client.dart';
import 'custom_cache_interceptor.dart';
import 'pretty_dio_logger.dart';

class DioClient implements ApiClient {
  String store = 'default';
  late Dio dio;
  String accessToken = "Bearer fiakb9318uishfsksn5oibbynn86gb3w";
  String baseUrl =
      kReleaseMode ? 'http://78.142.47.247:9990' : 'http://192.168.1.7:9990';

  DioClient() {
    dio = Dio();

    dio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 1000000),
      receiveTimeout: const Duration(milliseconds: 1000000),
    );

    dio.interceptors
      ..add(CacheInterceptor())
      ..add(
        PrettyDioLogger(
          maxWidth: 80,
          error: true,
          request: true,
          requestHeader: true,
          requestBody: true,
        ),
      );
  }

  Future<Options> getOptions({String? t}) async {
    Map<String, dynamic> headers = {'Accept': 'application/json'};
    var token = t ?? await Prefs.getToken();
    if (token != null) {
      headers['Authorization'] = token;
    }
    headers['Content-Type'] = 'application/json';
    print(headers);
    return Options(
      headers: headers,
      responseType: ResponseType.json,
    );
  }

  @override
  Future delete(String path, {body, query, t}) async {
    var response = await dio.delete(
      (path),
      data: body,
      queryParameters: query,
      options: await getOptions(t: t),
    );
    return response.data;
  }

  @override
  Future get(String path, {query, Options? options, t}) async {
    var response = await dio.get(
      (path),
      queryParameters: query,
      options: options ?? await getOptions(t: t),
    );
    return response.data;
  }

  @override
  Future patch(String path, body, {query}) async {
    var response = await dio.patch(
      (path),
      data: body,
      queryParameters: query,
      options: await getOptions(),
    );
    return response.data;
  }

  @override
  Future post(String path, body, {query, t, bool isBuildUrl = true}) async {
    var response = await dio.post(
      (path),
      data: body,
      queryParameters: query,
      options: await getOptions(t: t),
    );
    return response.data;
  }

  @override
  Future put(String path, body, {query, t}) async {
    var response = await dio.put(
      (path),
      data: body,
      queryParameters: query,
      options: await getOptions(t: t),
    );
    return response.data;
  }
}
