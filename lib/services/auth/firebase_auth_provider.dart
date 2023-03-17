import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hippodrome_app/firebase_options.dart';
import 'package:hippodrome_app/services/auth/auth_exception.dart';
import 'package:hippodrome_app/services/auth/auth_provider.dart';
import 'package:hippodrome_app/services/auth/auth_user.dart';

class FirebaseAuthProvider implements AuthProvider {
  const FirebaseAuthProvider();

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthExeption();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else {
        throw GenericAuthAuthException();
      }
    } catch (_) {
      throw GenericAuthAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else if (e.code == 'user-disabled') {
        throw UserDisabledAuthException();
      } else {
        throw GenericAuthAuthException();
      }
    } catch (e) {
      throw GenericAuthAuthException();
    }
  }

  @override
  Future<void> logout() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> reload() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
    } else {
      throw GenericAuthAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<AuthUser> googleLogin({required GoogleSignIn googleSignIn}) async {
    try {
      GoogleSignInAccount? gAccount = await googleSignIn.signIn();
      if (gAccount != null) {
        final gAuth = await gAccount.authentication;
        await FirebaseAuth.instance
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: gAuth.idToken,
          accessToken: gAuth.accessToken,
        ));

        final isSignedIn = await googleSignIn.isSignedIn();
        final user = currentUser;

        if (user != null && isSignedIn) {
          return user;
        } else {
          throw UserNotLoggedInAuthException();
        }
      } else {
        throw UserNotLoggedInAuthException();
      }
    } catch (e) {
      throw GenericAuthAuthException();
    }
  }
}
