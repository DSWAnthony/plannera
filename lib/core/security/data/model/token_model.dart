import 'package:plannera/core/security/data/model/auth_token.dart';

class TokenModel {
  final String access;
  final String refresh;
  TokenModel({required this.access, required this.refresh});
  factory TokenModel.fromJson(Map<String,dynamic> json) => TokenModel(
    access: json['token'],
    refresh: json['token'],
  );
  Map<String,dynamic> toJson() => {'token': access, 'refreshToken': refresh};
  Token toEntity() => Token(accessToken: access, refreshToken: refresh);
}