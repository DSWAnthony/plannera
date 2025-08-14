import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannera/core/security/state/auth_state.dart';
import 'package:plannera/core/security/usecases/check_auth.dart';
import 'package:plannera/core/security/usecases/get_profile.dart';
import 'package:plannera/core/security/usecases/login_usecase.dart';
import 'package:plannera/core/security/usecases/logout_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  final Login loginUsecase;
  final GetProfile getProfileUsecase;
  final CheckAuth checkAuth;
  final LogoutUsecase logoutUsecase;

  AuthCubit({
    required this.loginUsecase,
    required this.getProfileUsecase,
    required this.checkAuth,
    required this.logoutUsecase,
  }) : super(AuthState());

  Future<void> checkAuthOnStart() async {
    final auth = await checkAuth();
    print(auth); 
    if (auth.isSome()) {
      emit(state.copyWith(isAuthenticated: true));
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    final res = await loginUsecase(email, password);
    res.fold(
      (failure) => emit(
        state.copyWith(
          isError: true,
          errorMessage: failure.message,
          isLoading: false,
        ),
      ),
      (user) => emit(
        state.copyWith(isAuthenticated: true, user: user, isLoading: false),
      ),
    );
  }

  Future<void> logout() async {
    await logoutUsecase();
    emit(state.copyWith(isAuthenticated: false, user: null));
  }
}
