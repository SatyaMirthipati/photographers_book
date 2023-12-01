import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'login_expired_screen.dart';
import 'no_internet_screen.dart';

class ErrorHandling {
  static String parseError(error) {
    print('###ErrorHandling###');
    print(error);
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.badResponse:
            if (error.response?.statusCode == 400) {
              var map = error.response?.data;
              return badRequestMsg(map);
            } else if (error.response?.statusCode == 422) {
              return error.response?.data?['message'];
            } else if (error.response?.statusCode == 404) {
              return error.response?.data?['message'];
            } else if (error.response?.statusCode == 401) {
              Future.delayed(
                const Duration(seconds: 1),
                LoginExpiredScreen.open,
              );
              if (error.response?.data?['message'] != null) {
                return error.response?.data?['message'];
              }
              return 'Session expired';
            }
            return error.response?.data?['message'];
          case DioExceptionType.unknown:
            if (error.error is SocketException) {
              Future.delayed(const Duration(seconds: 1), NoInternetScreen.open);
              print('SocketException');
              print(error.error);
              if (kReleaseMode) return 'Unable to connect';
              return (error.error as SocketException).message;
            }
            if (kReleaseMode) return 'Unknown error!';
            return error.response?.data?['message'];
          default:
            if (kReleaseMode) return 'Unknown error!';
            return error.response?.data?['message'];
        }
      } else if (error is Exception) {
        return error.toString().replaceFirst('Exception: ', '');
      }
    } catch (e) {
      return 'Unknown error!';
    }
    return error?.toString() ?? 'Unknown error!';
  }

  static String badRequestMsg(map) {
    if (map is Map<String, dynamic>) {
      var message = map['message'] as String;
      if (map['parameters'] == null) return message;
      var params = map['parameters'] as List;
      for (int i = 0; i < params.length; i++) {
        message = message.replaceFirst('%${i + 1}', params[i]);
      }
      return message;
    } else {
      return 'Unknown error!';
    }
  }
}
