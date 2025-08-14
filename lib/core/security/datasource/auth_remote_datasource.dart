import 'package:dio/dio.dart';
import 'package:plannera/core/security/model/auth_user.dart';
import 'package:plannera/core/security/model/token_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthUser> login(String email, String password);
  Future<TokenModel> refreshToken(String refreshToken);
  Future<AuthUser> getProfile();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;
  AuthRemoteDatasourceImpl(this.dio);

  @override
  Future<AuthUser> login(String email, String password) async {
    final resp = await dio.post('/auth/login', data: {'correo': email, 'password': password});
    print(resp.data);
    return AuthUser.fromJson(resp.data);
  }

  @override
  Future<TokenModel> refreshToken(String refreshToken) async {
    final resp = await dio.post('/auth/refresh', data: {'refreshToken': refreshToken});
    return TokenModel.fromJson(resp.data);
  }

  @override
  Future<AuthUser> getProfile() async {
    final resp = await dio.get('/auth/me');
    return AuthUser.fromJson(resp.data);
  }
}