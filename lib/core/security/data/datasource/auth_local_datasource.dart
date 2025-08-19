import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plannera/core/security/data/model/user_model.dart';

abstract class AuthLocalDatasource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCachedUser();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDatasourceImpl(this.secureStorage);

  @override
  Future<void> cacheUser(UserModel user) async {
    await secureStorage.write(key: 'CACHED_USER', value: user.toRawJson());
  }

  @override
  Future<void> clearCachedUser() async {
    await secureStorage.delete(key: 'CACHED_USER');
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final raw = await secureStorage.read(key: 'CACHED_USER');

    if (raw == null) return null;

    try {
      return UserModel.fromRawJson(raw);
    } catch (e) {
      
      await clearCachedUser();
      return null;
    }
  }
}
