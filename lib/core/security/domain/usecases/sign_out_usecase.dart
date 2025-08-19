import 'package:dartz/dartz.dart';
import 'package:plannera/core/error/auth_failure.dart';
import 'package:plannera/core/security/domain/repositories/auth_repository.dart';

class SignOutUsecase {
  final AuthRepository repository;
  SignOutUsecase(this.repository);

  Future<Either<AuthFailure, void>> call() {
    return repository.signOut();
  }
}