import 'package:first/screens/authenticate/login.dart';
import 'package:first/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const loading());
}

class loading extends StatelessWidget {
  const loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "petpalz",
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 76, 0, 198), // Start color
                Color.fromARGB(255, 122, 39, 255),
                Color.fromARGB(255, 146, 79, 255),
                Color.fromARGB(255, 169, 115, 255),
                Color.fromARGB(255, 222, 201, 255), // End color
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/logo1.png",
                    width: 120, // Adjust as needed
                  ),
                ),
                const SizedBox(height: 16), // Add spacing between logo and text
                const Text(
                  "PetPalz",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    height: 30), // Add spacing between text and buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Loging()));
                  },
                  child: const Text("Login"),
                ),
                const SizedBox(height: 12), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
