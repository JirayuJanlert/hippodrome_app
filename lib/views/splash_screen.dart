import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {});
    super.initState();
  }

  // navigateUser() {
  //   User user = _auth.currentUser;
  //   // checking whether user already loggedIn or not
  //   if (user == null) {
  //     Timer(Duration(milliseconds: 100),
  //         () => Navigator.pushReplacementNamed(context, "/login"));
  //   } else {
  //     Timer(
  //       Duration(milliseconds: 100),
  //       () => Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => HomePage()),
  //           (Route<dynamic> route) => false),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    image: AssetImage("assets/icons/Logo.png"),
                    fit: BoxFit.fill),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SpinKitWave(
                    color: Colors.blueGrey, type: SpinKitWaveType.start),
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
  }
}
