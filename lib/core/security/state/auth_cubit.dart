import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannera/core/security/state/auth_state.dart';

import 'package:plannera/core/security/domain/usecases/get_current_user.dart';
import 'package:plannera/core/security/domain/usecases/sign_in_usecase.dart';
import 'package:plannera/core/security/domain/usecases/sign_out_usecase.dart';
import 'package:plannera/core/security/domain/usecases/sign_up_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
  final SignOutUsecase signOutUsecase;
  final GetCurrentUser getCurrentUser;


  AuthCubit({
    required this.signInUsecase,
    required this.signUpUsecase,
    required this.signOutUsecase,
    required this.getCurrentUser
  }) : super(AuthState());

  Future<void> checkAuthOnStart() async {
    final auth = await getCurrentUser();
    

    auth.fold(
      (failure) {
        emit(state.copyWith(isAuthenticated: false));
      },
      (user) {
        print(user);
        emit(state.copyWith(isAuthenticated: true, user: user));
      },
    );

  }

  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    final res = await signInUsecase(email: email, password: password);
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

  Future<void> signUp(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    final res = await signUpUsecase(email: email, password: password);
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

  Future<void> signOut() async {
    await signOutUsecase();
    emit(state.copyWith(isAuthenticated: false, user: null));
  }

}
