
import 'package:dartz/dartz.dart';
import 'package:plannera/core/error/auth_failure.dart';
import 'package:plannera/core/security/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, UserEntity>> signUp({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, void>> signOut();

  Future<Either<AuthFailure, UserEntity>> getCurrentUser();

}
