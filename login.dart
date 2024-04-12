import 'package:first/services/auth.dart';
import 'package:first/shared/loading.dart';
import 'package:flutter/material.dart';

class Loging extends StatefulWidget {
  final Function()? onTap;
  const Loging({Key? key, this.onTap}) : super(key: key);
  @override
  _LogingState createState() => _LogingState();
}

class _LogingState extends State<Loging> {
  final AuthService _auth = AuthService();
  bool loading = false;

  //text editing controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void checkEmailPass() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() => loading = true);
      dynamic result = await _auth.signinWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim());

      if (result == null) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Could not sign in with those credentials.'),
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email or password is empty.'),
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.deepPurple,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          hintStyle: const TextStyle(color: Colors.white),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.deepPurple,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color.fromARGB(255, 255, 255, 255)),
      ),
      home: SafeArea(
        child: loading
            ? const Loading()
            : Scaffold(
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 76, 0, 198),
                        Color.fromARGB(255, 122, 39, 255),
                        Color.fromARGB(255, 146, 79, 255),
                        Color.fromARGB(255, 169, 115, 255),
                        Color.fromARGB(255, 222, 201, 255),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.6,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/logo1.png",
                                  width: 100,
                                  height: 100,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "PetPalz",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    hintText: "Email",
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  onChanged: (val) {},
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                  onChanged: (val) {},
                                  obscureText: true,
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: checkEmailPass,
                                  child: const Text("Login"),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: const Text(
                                    " Register ?",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
