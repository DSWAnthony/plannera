import 'package:dartz/dartz.dart';
import 'package:plannera/core/error/auth_failure.dart';
import 'package:plannera/core/security/domain/entities/user_entity.dart';
import 'package:plannera/core/security/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repo;
  GetCurrentUser(this.repo);

  Future<Either<AuthFailure, UserEntity>> call() => repo.getCurrentUser();
}