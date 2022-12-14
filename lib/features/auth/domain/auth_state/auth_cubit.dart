import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:it_client/app/domain/error_entity/error_entity.dart';
import 'package:it_client/features/auth/domain/auth_repository.dart';
import 'package:it_client/features/auth/domain/entities/user_entity/user_entity.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

@Singleton()
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState.notauthorized());

  final AuthRepository authRepository;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity = await authRepository.signIn(
        email: email,
        password: password,
      );
      emit(AuthState.authorized(userEntity));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity = await authRepository.signUp(
        email: email,
        password: password,
        username: username,
      );
      emit(AuthState.authorized(userEntity));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }

  Future<void> getProfile() async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      final UserEntity newUserEntity = await authRepository.getProfile();
      emit(
        state.maybeWhen(
          orElse: () => state,
          authorized: (userEntity) => AuthState.authorized(
            userEntity.copyWith(
              email: newUserEntity.email,
              username: newUserEntity.username,
            ),
          ),
        ),
      );
      _updateUserState(
        const AsyncSnapshot.withData(
            ConnectionState.done, "???????????????? ?????????????????? ????????????"),
      );
    } catch (error) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  void _updateUserState(AsyncSnapshot asyncSnapshot) {
    emit(state.maybeWhen(
      orElse: () => state,
      authorized: (userEntity) {
        return AuthState.authorized(
            userEntity.copyWith(userState: asyncSnapshot));
      },
    ));
  }

  Future<void> updateProfile({
    required String username,
    required String email,
  }) async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      await Future.delayed(const Duration(seconds: 1));
      final UserEntity newUserEntity = await authRepository.updateProfile(
        username: username,
        email: email,
      );
      emit(
        state.maybeWhen(
          orElse: () => state,
          authorized: (userEntity) => AuthState.authorized(
            userEntity.copyWith(
              username: newUserEntity.username,
              email: newUserEntity.email,
            ),
          ),
        ),
      );
      _updateUserState(
        const AsyncSnapshot.withData(
            ConnectionState.done, "???????????????? ???????????????????? ????????????"),
      );
    } catch (error) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      await Future.delayed(const Duration(seconds: 1));
      if (newPassword.trim().isEmpty == true ||
          newPassword.trim().isEmpty == true) {
        throw ErrorEntity(message: "???????? ???? ?????????? ???????? ??????????????");
      }
      final message = await authRepository.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      _updateUserState(AsyncSnapshot.withData(ConnectionState.done, message));
    } catch (error) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  Future<void> refreshToken() async {
    final refreshToken = state.whenOrNull(
      authorized: (userEntity) => userEntity.refreshToken,
    );
    try {
      final UserEntity userEntity =
          await authRepository.refreshToken(refreshToken: refreshToken);
      emit(AuthState.authorized(userEntity));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final state = AuthState.fromJson(json);
    return state.whenOrNull(
      authorized: (userEntity) => AuthState.authorized(userEntity),
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state
            .whenOrNull(
              authorized: (userEntity) => AuthState.authorized(userEntity),
            )
            ?.toJson() ??
        AuthState.notauthorized().toJson();
  }

  void logOut() => emit(AuthState.notauthorized());

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(AuthState.error(error));
    super.addError(error, stackTrace);
  }
}
