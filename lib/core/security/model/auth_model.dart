class AuthModel {
  final String id;
  final String email;
  final String name;
  final String accessToken;
  final String? refreshToken;
  final List<String> roles;

  AuthModel({
    required this.id,
    required this.email,
    required this.name,
    required this.accessToken,
    this.refreshToken,
    this.roles = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'roles': roles,
  };

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String?,
    roles: List<String>.from(json['roles'] ?? []),
  );

  AuthModel copyWith({ String? accessToken, String? refreshToken }) => AuthModel(
    id: id,
    email: email,
    name: name,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    roles: roles,
  );
}
