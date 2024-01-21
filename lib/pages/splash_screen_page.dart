import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/home_first_screen.dart';
import 'package:tasty_recipe_app/pages/sign_1_2_login/login_screen_page.dart';

//splash screen
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  StreamSubscription<User?>? _listener;

  @override
  void initState() {
    initSplash();
    super.initState();
  }

//check to user
  void initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    // listen in and out
    _listener = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const LoginScreenPage()));
      } else {
        //go to login page
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeFirstScreen()
                // SignInScreenPage()
                ));
      }
    });
  }

  @override
  void dispose() {
    _listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Lottie.network(
            'https://lottie.host/4d024b33-296f-4896-a687-03467d77a699/7LSwabKqqe.json',
          ),
        ),
      ),
    );
  }
}

////check to user
//   void initSplash() async {
//     await Future.delayed(Duration(seconds: 6));
//     //checkuser mogawad or not
//     if (PreferencesService.checkUser()) {
//       //go to  SignupPage -first page
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => LoginPage()));
//     } else {
//       //go to login page
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => SignInPage()));
//     }
//   }
