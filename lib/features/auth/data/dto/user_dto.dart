import 'package:it_client/features/auth/domain/entities/user_entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final dynamic id;
  final dynamic username;
  final dynamic email;
  final dynamic accessToken;
  final dynamic refreshToken;

  UserDto({
    this.id,
    this.username,
    this.email,
    this.accessToken,
    this.refreshToken,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      email: email.toString(),
      username: username.toString(),
      id: id.toString(),
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
