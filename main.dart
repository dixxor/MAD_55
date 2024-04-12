import 'package:first/firebase_options.dart';
import 'package:first/models/user.dart';
import 'package:first/services/auth.dart';
import 'package:first/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          catchError: (_, __) => null,
          initialData: null,
          value: AuthService().currUser,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: wrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
