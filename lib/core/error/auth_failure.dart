// auth_failure.dart
abstract class AuthFailure {
  final String message;
  const AuthFailure(this.message);

}

class ServerFailure2 extends AuthFailure {
  ServerFailure2(super.message);
}
class EmailAlreadyInUseFailure extends AuthFailure {
  EmailAlreadyInUseFailure(super.message);
}
class InvalidEmailFailure extends AuthFailure {
  InvalidEmailFailure(super.message);
}
class WrongPasswordFailure extends AuthFailure {
  WrongPasswordFailure(super.message);
}
class CancelledByUserFailure extends AuthFailure {
  CancelledByUserFailure(super.message);
}
