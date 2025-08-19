import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:plannera/core/security/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? displayName;
  final DateTime cachedAt;

  UserModel({required super.id, super.email, required super.emailVerified, required this.cachedAt, this.displayName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      emailVerified: json['email_verified'],
      cachedAt: DateTime.parse(json['cached_at']),
      displayName: json['display_name'],
    );
  }

  factory UserModel.fromFirebaseUser(User user) => UserModel(
        id: user.uid,
        email: user.email,
        displayName: user.displayName,
        emailVerified: user.emailVerified,
        cachedAt: DateTime.now(),
      );


  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      emailVerified: emailVerified,
    );
  }


  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'emailVerified': emailVerified,
        'cachedAt': cachedAt.toIso8601String(),
  };

  String toRawJson() => json.encode(toJson());
  factory UserModel.fromRawJson(String raw) => UserModel.fromJson(json.decode(raw));

}