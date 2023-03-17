import 'package:google_sign_in/google_sign_in.dart';
import 'package:hippodrome_app/services/auth/auth_provider.dart';
import 'package:hippodrome_app/services/auth/auth_user.dart';
import 'package:hippodrome_app/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final FirebaseAuthProvider provider;
  const AuthService({required this.provider});

  factory AuthService.firebase() =>
      const AuthService(provider: FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser(
          {required String email, required String password}) =>
      provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> login({required String email, required String password}) =>
      provider.login(
        email: email,
        password: password,
      );

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> reload() => provider.reload();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<AuthUser> googleLogin({required GoogleSignIn googleSignIn}) =>
      provider.googleLogin(googleSignIn: googleSignIn);
}
