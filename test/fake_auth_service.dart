import 'package:dev_shepherd/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FakeAuthService implements AuthService {
  bool signUpCalled = false;
  bool loginCalled = false;

  String? signUpEmail;
  String? signUpPassword;

  String? loginEmail;
  String? loginPassword;

  bool shouldSignUpSucceed = false;
  bool shouldLoginSucceed = false;

  @override
  Future<UserCredential> signUp(
      String email,
      String password,
      ) async {
    signUpCalled = true;
    signUpEmail = email;
    signUpPassword = password;

    if (!shouldSignUpSucceed) {
      throw UnimplementedError();
    }

    throw UnimplementedError();
  }

  @override
  Future<UserCredential> login(
      String email,
      String password,
      ) async {
    loginCalled = true;
    loginEmail = email;
    loginPassword = password;

    throw UnimplementedError();
  }
}