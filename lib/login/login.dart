import 'package:json_annotation/json_annotation.dart';
part 'login.g.dart';

@JsonSerializable()
class LoginRequest {
  final String username;
  final String password;
  final String client;

  LoginRequest(this.username, this.password, {this.client = 'android'});

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class TokenResponse {
  final String token;
  final int code;

  TokenResponse(this.token, this.code);

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
