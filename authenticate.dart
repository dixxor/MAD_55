import 'package:first/screens/authenticate/login.dart';
import 'package:first/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class authenticate extends StatefulWidget {
  const authenticate({super.key});

  @override
  State<authenticate> createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {
  bool showLogIn = true;

  void toggleView() {
    //if true make it false vice versa
    setState(() => showLogIn = !showLogIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showLogIn) {
      // return SignIn(toggleView : toggleView);
      return Loging(onTap: toggleView);
    } else {
      // return Register(toggleView : toggleView);
      return Register(onTap: toggleView);
    }
  }
}
