import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:it_client/app/domain/app_api.dart';
import 'package:it_client/features/auth/data/dto/user_dto.dart';
import 'package:it_client/features/auth/domain/auth_repository.dart';
import 'package:it_client/features/auth/domain/entities/user_entity/user_entity.dart';

@Injectable(as: AuthRepository)
@dev
class NetworkAuthRepository implements AuthRepository {
  final AppApi api;

  NetworkAuthRepository(this.api);

  @override
  Future<UserEntity> getProfile() async {
    try {
      final response = await api.getProfile();
      return UserDto.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> refreshToken({String? refreshToken}) async {
    try {
      final response = await api.refreshToken(refreshToken: refreshToken);
      return UserDto.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signIn(
      {required String email, required String password}) async {
    try {
      final response = await api.signIn(email: email, password: password);
      return UserDto.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final response = await api.signUp(
        email: email,
        username: username,
        password: password,
      );

      return UserDto.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      final Response response = await api.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return response.data["message"];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future updateProfile({String? username, String? email}) async {
    try {
      final response = await api.updateProfile(
        username: username,
        email: email,
      );
      return UserDto.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }
}
