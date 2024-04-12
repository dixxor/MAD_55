import 'package:first/home.dart';
import 'package:first/models/user.dart';
import 'package:first/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class wrapper extends StatelessWidget {
  const wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    //return home or authenticate
    if (user == null) {
      return authenticate();
    } else {
      return HomePage();
    }
  }
}
