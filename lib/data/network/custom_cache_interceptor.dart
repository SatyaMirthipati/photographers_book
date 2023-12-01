import 'package:dio/dio.dart';

class CacheInterceptor extends Interceptor {
  CacheInterceptor();

  final _cache = <Uri, Response>{};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var segments = options.uri.pathSegments;
    if (options.method != 'GET') return super.onRequest(options, handler);
    if (!segments.contains('categories')) {
      return super.onRequest(options, handler);
    }
    Response? response = _cache[options.uri];
    if (response != null) {
      print("cache hit: ${options.uri} \n");
      return handler.resolve(response);
    } else {
      super.onRequest(options, handler);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.method != 'GET') {
      return super.onResponse(response, handler);
    }
    var segments = response.requestOptions.uri.pathSegments;
    if (!segments.contains('categories')) {
      return super.onResponse(response, handler);
    }
    _cache[response.requestOptions.uri] = response;
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('onError: $err');
    handler.next(err);
  }
}
