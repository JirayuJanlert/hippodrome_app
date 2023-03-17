import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hippodrome_app/views/auth/login_view.dart';
import 'package:hippodrome_app/views/home_page.dart';
import 'package:hippodrome_app/views/splash_screen.dart';

var routes = <String, WidgetBuilder>{
  "/login": (BuildContext context) => const LoginView(),
  "/home": (BuildContext context) => const HomePage(),
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const SplashScreen(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
