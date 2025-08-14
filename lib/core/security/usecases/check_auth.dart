import 'package:dartz/dartz.dart';
import 'package:plannera/core/security/model/auth_token.dart';
import 'package:plannera/core/security/repository/auth_repositori.dart';

class CheckAuth {

  final AuthRepository repo;
  CheckAuth(this.repo);

  Future<Option<Token>> call() {
    return repo.getStoredToken();
  }
}