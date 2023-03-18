import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hippodrome_app/services/auth/auth_provider.dart';
import 'package:hippodrome_app/services/auth/auth_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthProvider _provider;
  AuthBloc(AuthProvider provider)
      : _provider = provider,
        super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventLogin>(_onLogin);
    on<AuthEventLogOut>(_onLogout);
    on<AuthEventInitialize>(_onInitialize);
    on<AuthEventRegister>(_onRegister);
    on<AuthEventSendEmailVerification>(_onSendEmailVerification);
    on<AuthEventShouldRegister>(_onShouldRegister);
  }

  void _onRegister(AuthEventRegister event, Emitter<AuthState> emit) async {
    try {
      await _provider.createUser(
        email: event.email,
        password: event.password,
      );
      await _provider.sendEmailVerification();
      emit(const AuthStateNeedsEmailVerification(isLoading: false));
    } on Exception catch (e) {
      emit(AuthStateRegistering(
        exception: e,
        isLoading: false,
      ));
    }
  }

  void _onInitialize(AuthEventInitialize event, Emitter<AuthState> emit) async {
    try {
      await _provider.initialize();
      final user = _provider.currentUser;
      if (user != null) {
        if (!user.isEmailVerified) {
          emit(const AuthStateNeedsEmailVerification(isLoading: false));
        } else {
          emit(AuthStateLoggedIn(
            user: user,
            isLoading: false,
          ));
        }
      } else {
        emit(const AuthStateLoggedOut(
          isLoading: false,
          exception: null,
        ));
      }
    } on Exception catch (e) {
      emit(AuthStateLoggedOut(
        isLoading: false,
        exception: e,
      ));
    }
  }

  void _onLogin(AuthEventLogin event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoggedOut(
        isLoading: true,
        exception: null,
        loadingText: 'Please wait whild I log you in'));
    try {
      final user = await _provider.login(
        email: event.email,
        password: event.password,
      );
      if (!user.isEmailVerified) {
        emit(const AuthStateLoggedOut(
          isLoading: false,
          exception: null,
        ));
        emit(const AuthStateNeedsEmailVerification(
          isLoading: false,
        ));
      } else {
        emit(const AuthStateLoggedOut(
          isLoading: false,
          exception: null,
        ));

        emit(AuthStateLoggedIn(user: user, isLoading: false));
      }
    } on Exception catch (e) {
      emit(AuthStateLoggedOut(
        exception: e,
        isLoading: false,
      ));
    }
  }

  void _onLogout(AuthEventLogOut event, Emitter<AuthState> emit) async {
    try {
      await _provider.logout();
      final user = _provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(isLoading: false, exception: null));
      }
    } on Exception catch (e) {
      emit(AuthStateLoggedOut(isLoading: false, exception: e));
    }
  }

  void _onSendEmailVerification(
      AuthEventSendEmailVerification event, Emitter<AuthState> emit) async {
    await _provider.sendEmailVerification();
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state);
  }

  void _onShouldRegister(
      AuthEventShouldRegister event, Emitter<AuthState> emit) async {
    emit(const AuthStateRegistering(isLoading: false, exception: null));
  }
}
