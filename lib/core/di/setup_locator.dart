import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:plannera/core/network/dio_client.dart';
import 'package:plannera/core/security/data/datasource/auth_local_datasource.dart';
import 'package:plannera/core/security/data/datasource/auth_remote_datasource.dart';
import 'package:plannera/core/security/domain/repositories/auth_repository.dart';
import 'package:plannera/core/security/data/repositories/auth_repository_impl.dart';
import 'package:plannera/core/security/domain/usecases/get_current_user.dart';
import 'package:plannera/core/security/state/auth_cubit.dart';
import 'package:plannera/core/security/domain/usecases/sign_in_usecase.dart';
import 'package:plannera/core/security/domain/usecases/sign_out_usecase.dart';
import 'package:plannera/core/security/domain/usecases/sign_up_usecase.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // core
  sl.registerLazySingleton(() => FlutterSecureStorage());

  // dio

  // sl.registerLazySingleton(() => DioClient(secureStorage: sl()));

  // datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sl()),
  );

  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // repository (impl)
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // usecases
  // sl.registerLazySingleton(() => GetProfile(sl()));
  // sl.registerLazySingleton(() => CheckAuth(sl()));

  sl.registerLazySingleton(() => SignOutUsecase(sl()));
  sl.registerLazySingleton(() => SignInUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));


  // cubit
  sl.registerLazySingleton(
    () => AuthCubit(
      signInUsecase: sl(),
      signUpUsecase: sl(),
      signOutUsecase: sl(),
      getCurrentUser: sl(),
    ),
  );
}
