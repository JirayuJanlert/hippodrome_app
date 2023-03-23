import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hippodrome_app/services/auth/bloc/auth_bloc.dart';
import 'package:hippodrome_app/views/auth/login_view.dart';
import 'package:hippodrome_app/views/auth/register_view.dart';
import 'package:hippodrome_app/views/home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget splashScreen() => Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/icons/Logo.png"), fit: BoxFit.fill),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SpinKitWave(color: Colors.blueGrey, type: SpinKitWaveType.start),
              SizedBox(
                height: 20,
              ),
              Text(
                "Book your movies\n with Hippodrome",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      )));

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateUninitialized) {
          return splashScreen();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateLoggedIn) {
          return const HomePageView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Center(
            child: SpinKitWave(
                color: Colors.blueGrey, type: SpinKitWaveType.start),
          );
        }
      },
    );
  }
}
