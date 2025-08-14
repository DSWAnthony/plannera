
import 'package:plannera/core/security/repository/auth_repositori.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase(this.authRepository);

  Future<void> call() async {
    await authRepository.logout();
  }
}