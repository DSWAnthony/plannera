// core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plannera/core/constants/name_api.dart';

class DioClient {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  DioClient({required this.secureStorage})
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiSanRemo.baseUrl,
            connectTimeout: const Duration(seconds: 30),
          ),
        ) {
    // Interceptor para añadir token automáticamente
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Solo añade token si existe
        final token = await secureStorage.read(key: 'acessToken');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Lógica de refresh token
          try {
            final newToken = await _refreshToken();
            if (newToken != null) {
              // Actualiza token en la petición original
              error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              // Reintenta la petición
              final response = await dio.fetch(error.requestOptions);
              return handler.resolve(response);
            }
          } catch (e) {
            // Si falla el refresh, forzar logout
            await secureStorage.deleteAll();
            // Podrías añadir: context.go('/login') usando un GlobalKey<NavigatorState>
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<String?> _refreshToken() async {
    try {
      final token = await secureStorage.read(key: 'refreshToken');
      if (token!.isEmpty) return null;

      // Usa una instancia temporal SIN interceptor para evitar bucles
      final tempDio = Dio();
      final response = await tempDio.post(
        '${ApiSanRemo.baseUrl}/auth/refresh',
        data: {'refreshToken': token},
      );
      
      final newToken = response.data['accessToken'];
      await secureStorage.write(key: 'accessToken', value: newToken);
      return newToken;
    } catch (e) {
      return null;
    }
  }
}