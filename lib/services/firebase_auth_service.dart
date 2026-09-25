import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth);

  @override
  Future<UserCredential> signUp(
      String email,
      String password,
      ) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> login(
      String email,
      String password,
      ) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}