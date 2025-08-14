
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:plannera/core/error/failure.dart';
import 'package:plannera/core/security/datasource/auth_remote_datasource.dart';
import 'package:plannera/core/security/model/auth_token.dart';
import 'package:plannera/core/security/model/auth_user.dart';
import 'package:plannera/core/security/repository/auth_repositori.dart';
import 'package:plannera/core/services/secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remote;
  final SecureStorage storage;

  AuthRepositoryImpl({required this.remote, required this.storage});

  @override
  Future<Either<Failure, AuthUser>> login(String email, String password) async {
    try {
      final authUser = await remote.login(email, password);

      await storage.saveToken(Token(
        accessToken: authUser.accessToken, 
        refreshToken: authUser.refreshToken ?? '')
      );
      
      return Right(authUser);
      
    } on DioException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Token>> refreshToken(String refreshToken) async {
    try {
      final tokenModel = await remote.refreshToken(refreshToken);
      final token = tokenModel.toEntity();
      await storage.saveToken(token);
      return Right(token);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await storage.clear();
      return Right(null);
    } catch (e) {
      return Left(LocalFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> getProfile() async {
    try {
      final userModel = await remote.getProfile();
      return Right(userModel);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Option<Token>> getStoredToken() async {
    final t = await storage.getToken();
    return optionOf(t);
  }
}