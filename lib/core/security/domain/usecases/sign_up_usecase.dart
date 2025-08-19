import 'package:dartz/dartz.dart';
import 'package:plannera/core/error/auth_failure.dart';
import 'package:plannera/core/security/domain/entities/user_entity.dart';
import 'package:plannera/core/security/domain/repositories/auth_repository.dart';

class SignUpUsecase {
  final AuthRepository repository;
  SignUpUsecase(this.repository);

  Future<Either<AuthFailure, UserEntity>> call({
    required String email,
    required String password,
  }) {
    return repository.signUp(email: email, password: password);
  }
}
