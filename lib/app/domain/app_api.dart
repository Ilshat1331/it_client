abstract class AppApi {
  Future<dynamic> signUp({
    required String email,
    required String username,
    required String password,
  });

  Future<dynamic> signIn({
    required String email,
    required String password,
  });

  Future<dynamic> getProfile();

  Future<dynamic> updateProfile({String? username, String? email});

  Future<dynamic> updatePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<dynamic> refreshToken({String? refreshToken});

  Future<dynamic> request(String path);
}
