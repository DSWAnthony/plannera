import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:plannera/core/error/auth_failure.dart';
import 'package:plannera/core/security/data/datasource/auth_local_datasource.dart';
import 'package:plannera/core/security/data/datasource/auth_remote_datasource.dart';
import 'package:plannera/core/security/domain/entities/user_entity.dart';
import 'package:plannera/core/security/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDatasource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<AuthFailure, UserEntity>> getCurrentUser() async {
    final cached = await localDataSource.getCachedUser();

    if (cached != null) return Right(cached);

    final remote = remoteDataSource.getCurrentUser();

    if (remote != null) {
      await localDataSource.cacheUser(remote);
      return Right(remote);
    }

    return Left(ServerFailure2('No hay usuario'));
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final authUser = await remoteDataSource.signIn(email, password);

      await localDataSource.cacheUser(authUser);

      return Right(authUser);
    } on DioException catch (e) {
      return Left(ServerFailure2(e.toString()));
    } catch (e) {
      return Left(ServerFailure2(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      await localDataSource.clearCachedUser();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure2(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final authUser = await remoteDataSource.signUp(email, password);
      await localDataSource.cacheUser(authUser);

      return Right(authUser);
    } on DioException catch (e) {
      return Left(ServerFailure2(e.toString()));
    } catch (e) {
      return Left(ServerFailure2(e.toString()));
    }
  }
}
