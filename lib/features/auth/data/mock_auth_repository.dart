// import 'package:injectable/injectable.dart';
// import 'package:it_client/features/auth/domain/auth_repository.dart';
// import 'package:it_client/features/auth/domain/entities/user_entity/user_entity.dart';

// @Injectable(as: AuthRepository)
// @test
// class MockAuthRepository implements AuthRepository {
//   @override
//   Future getProfile() {
//     // TODO: implement getProfile
//     throw UnimplementedError();
//   }

//   @override
//   Future refreshToken({String? refreshToken}) {
//     // TODO: implement refreshToken
//     throw UnimplementedError();
//   }

//   @override
//   Future signIn({required String email, required String password}) {
//     return Future.delayed(
//       const Duration(seconds: 2),
//       () => UserEntity(email: email, username: "username", id: "-1"),
//     );
//   }

//   @override
//   Future signUp({
//     required String email,
//     required String username,
//     required String password,
//   }) {
//     return Future.delayed(
//       const Duration(seconds: 2),
//       () => UserEntity(email: email, username: username, id: "-1"),
//     );
//   }

//   @override
//   Future updatePassword(
//       {required String oldPassword, required String newPassword}) {
//     // TODO: implement updatePassword
//     throw UnimplementedError();
//   }

//   @override
//   Future updateProfile({String? username, String? email}) {
//     // TODO: implement updateProfile
//     throw UnimplementedError();
//   }
// }
