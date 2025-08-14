import 'package:dartz/dartz.dart';
import 'package:plannera/core/error/failure.dart';
import 'package:plannera/core/security/model/auth_user.dart';
import 'package:plannera/core/security/repository/auth_repositori.dart';

class GetProfile {
  final AuthRepository repo;
  GetProfile(this.repo);
  Future<Either<Failure, AuthUser>> call() => repo.getProfile();
}