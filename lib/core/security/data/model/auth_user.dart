class AuthUser {
  final int id;
  final String email;
  final String names;
  final String role;
  final String accessToken;
  final String? refreshToken;

  AuthUser({
    this.refreshToken,
    required this.accessToken,
    required this.id,
    required this.email,
    required this.names,
    this.role = 'user',
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['user']['id_usuario'] as int,
      email: json['user']['correo'] as String,
      names: json['user']['nombre'] as String,
      accessToken: json['token'] as String,
      refreshToken: json['token'] as String?,
      role: json['user']['rol'] as String? ?? 'user',
    );
  }
}
