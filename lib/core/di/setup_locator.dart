
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:plannera/core/network/dio_client.dart';
import 'package:plannera/core/security/datasource/auth_remote_datasource.dart';
import 'package:plannera/core/security/repository/auth_repositori.dart';
import 'package:plannera/core/security/repository/auth_repository_impl.dart';
import 'package:plannera/core/security/state/auth_cubit.dart';
import 'package:plannera/core/security/usecases/check_auth.dart';
import 'package:plannera/core/security/usecases/get_profile.dart';
import 'package:plannera/core/security/usecases/login_usecase.dart';
import 'package:plannera/core/security/usecases/logout_usecase.dart';
import 'package:plannera/core/services/secure_storage.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
   // core
  sl.registerLazySingleton(() => FlutterSecureStorage());
  sl.registerLazySingleton(() => SecureStorage(sl()));

  // dio

  sl.registerLazySingleton(() => DioClient(secureStorage: sl()));

  // datasources
  sl.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(
    sl<DioClient>().dio
  ));

  // repository (impl)
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remote: sl(), storage: sl()));

  // usecases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => GetProfile(sl()));
  sl.registerLazySingleton(() => CheckAuth(sl()));
  sl.registerCachedFactory(() => LogoutUsecase(sl()));

  // cubit
  sl.registerLazySingleton(() => AuthCubit(
        loginUsecase: sl(),
        getProfileUsecase: sl(),
        checkAuth: sl(),
        logoutUsecase: sl(),
  ));
  
}
