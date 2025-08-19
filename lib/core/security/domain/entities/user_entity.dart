class UserEntity {
  final String id;
  final String? email;
  final bool emailVerified;
  // puedes añadir displayName, photoUrl, etc.

  UserEntity({required this.id, this.email, required this.emailVerified});
}
