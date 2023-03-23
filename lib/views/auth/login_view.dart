import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hippodrome_app/services/auth/bloc/auth_bloc.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// GoogleSignIn _googleSignIn ;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _googleSignIn = GoogleSignIn(
    //   scopes: [
    //     'https://www.googleapis.com/auth/contacts.readonly',
    //   ],
    // );
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: h * 0.9,
        padding: EdgeInsets.only(top: h * 0.1, left: w * 0.1, right: w * 0.1),
        child: LoginForm(
          w: w,
          h: h,
        ),
      ),
      persistentFooterButtons: <Widget>[
        SizedBox(
            height: h * 0.05,
            width: w * 1.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Don't Have an Account?"),
                GestureDetector(
                  onTap: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventShouldRegister());
                  },
                  child: const Text(
                    "  SignUp",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                )
              ],
            ))
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.w,
    required this.h,
    // @required this.googleSignIn,
  }) : super(key: key);

  final double w;
  final double h;
  // final GoogleSignIn googleSignIn;

//
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool success = false;
  String userEmail = '';
  String password = '';
//  bool google_login;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              width: widget.w,
              alignment: Alignment.center,
              child: Image.asset('assets/icons/Logo.png'),
            ),
            SizedBox(
              height: widget.h * 0.05,
            ),
            TextFormField(
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return "This is required field";
                }
                return null;
              },
              controller: _usernameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "email address"),
            ),
            SizedBox(
              height: widget.h * 0.03,
            ),
            PasswordFormField(
              controller: _passwordController,
            ),
            Container(
                padding: EdgeInsets.only(
                    top: widget.h * 0.04, left: widget.w * 0.45),
                child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.blue),
                    ))),
            SizedBox(
              height: widget.h * 0.05,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: widget.w,
              height: widget.h * 0.11,
              child: TextButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepPurple),
                    elevation: MaterialStatePropertyAll(0),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder())),
                onPressed: () async {
                  setState(() {
                    userEmail = _usernameController.text;
                    password = _passwordController.text;
                  });
                  if (_formKey.currentState!.validate()) {
                    // central.signInWithEmail(context,
                    //     email: userEmail, password: password, auth: _auth);
                  }
                },
                child: const Text(
                  "Log-in with Email",
                  style: TextStyle(
                      color: Colors.white, letterSpacing: 2, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: widget.h * 0.01,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: widget.w * 1,
              height: widget.h * 0.11,
              child: TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    elevation: MaterialStatePropertyAll(0),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder())),
                onPressed: () async {
                  // central.loginWithGoogle(context, widget.googleSignIn, _auth);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                        image: AssetImage("assets/icons/google_logo.png"),
                        height: 35.0),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordFormField({Key? key, required this.controller})
      : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return "This is required field";
        }
        return null;
      },
      controller: widget.controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        hintText: "password",
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
      ),
      obscureText: !_showPassword,
    );
  }
} //ec