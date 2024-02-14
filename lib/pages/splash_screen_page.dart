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
    await Future.delayed(const Duration(seconds: 4));
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
            'https://lottie.host/876b36e1-7af8-4f14-beed-6281b33ebb4a/XslptGNdqS.json'
          ),
        ),
      ),
    );
  }
}

