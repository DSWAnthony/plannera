import 'package:plannera/core/security/model/auth_user.dart';

class AuthState {
  final AuthUser? user;
  final String? errorMessage;
  final bool isLoading;
  final bool isError;
  final bool isAuthenticated;

  AuthState({
    this.user,
    this.errorMessage,
    this.isLoading = false,
    this.isError = false,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    AuthUser? user,
    String? errorMessage,
    bool? isLoading,
    bool? isError,
    bool? isAuthenticated,
  }) {
    return AuthState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

}
