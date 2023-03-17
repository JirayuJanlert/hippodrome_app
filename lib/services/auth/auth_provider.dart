import 'package:google_sign_in/google_sign_in.dart';
import 'package:hippodrome_app/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<void> initialize();
  Future<AuthUser> login({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<void> reload();
  Future<void> sendEmailVerification();
  Future<AuthUser> googleLogin({required GoogleSignIn googleSignIn});
}
