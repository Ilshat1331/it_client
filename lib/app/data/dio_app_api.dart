import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:it_client/app/data/auth_interceptor.dart';
import 'package:it_client/app/domain/app_api.dart';
import 'package:it_client/app/domain/app_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Singleton(as: AppApi)
class DioAppApi implements AppApi {
  late final Dio dio;

  DioAppApi(AppConfig appConfig) {
    final options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: 15000,
    );
    dio = Dio(options);
    if (kDebugMode) dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<Response> getProfile() {
    try {
      return dio.get("/auth/user");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> refreshToken({String? refreshToken}) {
    try {
      return dio.post("/auth/token/$refreshToken");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> signIn({required String email, required String password}) {
    try {
      return dio.post("/auth/token", data: {
        "email": email,
        "password": password,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> signUp(
      {required String email,
      required String username,
      required String password}) {
    try {
      return dio.put("/auth/token", data: {
        "email": email,
        "username": username,
        "password": password,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> updatePassword(
      {required String oldPassword, required String newPassword}) {
    try {
      return dio.put("/auth/user", queryParameters: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> updateProfile({String? username, String? email}) {
    try {
      return dio.post("/auth/user", data: {
        "username": username,
        "email": email,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future request(String path) {
    try {
      return dio.request(path);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> fetch(options) {
    try {
      return dio.fetch(options);
    } catch (_) {
      rethrow;
    }
  }
}
