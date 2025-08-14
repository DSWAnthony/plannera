import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plannera/core/security/model/auth_token.dart';

class SecureStorage {
  final FlutterSecureStorage storage;
  
  SecureStorage(this.storage);

  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  Future<void> write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<void> saveToken(Token token) async {
    await storage.write(key: 'access', value: token.accessToken);
    await storage.write(key: 'refresh', value: token.refreshToken);
  }

  Future<Token?> getToken() async {
    final access = await storage.read(key: 'access');
    final refresh = await storage.read(key: 'refresh');
    if (access == null || refresh == null) return null;
    return Token(accessToken: access, refreshToken: refresh);
  }

  Future<void> clear() async {
    await storage.deleteAll();
  }
}
