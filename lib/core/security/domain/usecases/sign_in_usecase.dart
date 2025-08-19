// sign_in.dart
import 'package:dartz/dartz.dart';
import 'package:plannera/core/error/auth_failure.dart';
import 'package:plannera/core/security/domain/entities/user_entity.dart';
import 'package:plannera/core/security/domain/repositories/auth_repository.dart';
class SignInUsecase {
  final AuthRepository repository;
  SignInUsecase(this.repository);

  Future<Either<AuthFailure, UserEntity>> call({
    required String email,
    required String password,
  }) {
    return repository.signIn(email: email, password: password);
  }
}
