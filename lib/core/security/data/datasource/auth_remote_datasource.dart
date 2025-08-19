// firebase_auth_datasource.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plannera/core/security/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String password);
  Future<void> signOut();
  UserModel? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> signIn(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseUser(userCredential.user!);
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseUser(userCredential.user!);
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  @override
  UserModel? getCurrentUser() {
    final u = _firebaseAuth.currentUser;
    if (u == null) return null;
    return UserModel.fromFirebaseUser(u);
  }
}
