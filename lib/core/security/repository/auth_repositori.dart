
import 'package:dartz/dartz.dart';
import 'package:plannera/core/security/model/auth_token.dart';
import 'package:plannera/core/security/model/auth_user.dart';
import '../../../core/error/failure.dart';

abstract class AuthRepository {
  
  Future<Either<Failure, AuthUser>> login(String email, String password);
  Future<Either<Failure, AuthUser>> getProfile();
  Future<Either<Failure, Token>> refreshToken(String refreshToken);
  Future<Either<Failure, void>> logout();
  Future<Option<Token>> getStoredToken(); // Option<Token> from dartz (or nullable)
}
