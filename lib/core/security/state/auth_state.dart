
import 'package:plannera/core/security/domain/entities/user_entity.dart';

class AuthState {
  final UserEntity? user;
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
    UserEntity? user,
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
