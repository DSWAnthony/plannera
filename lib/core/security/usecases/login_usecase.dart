import 'package:dartz/dartz.dart';
import 'package:plannera/core/error/failure.dart';
import 'package:plannera/core/security/model/auth_user.dart';
import 'package:plannera/core/security/repository/auth_repositori.dart';

class Login {
  final AuthRepository repo;
  Login(this.repo);
  
  Future<Either<Failure, AuthUser>> call(String email, String password) {
    return repo.login(email, password);
  }
}
