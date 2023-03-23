import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hippodrome_app/services/auth/bloc/auth_bloc.dart';
import 'package:hippodrome_app/services/auth/firebase_auth_provider.dart';
import 'package:hippodrome_app/views/auth/login_view.dart';
import 'package:hippodrome_app/views/home_page.dart';
import 'package:hippodrome_app/views/splash_screen.dart';

var routes = <String, WidgetBuilder>{
  "/login": (BuildContext context) => const LoginView(),
  "/home": (BuildContext context) => const HomePageView(),
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(
    MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(const FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
