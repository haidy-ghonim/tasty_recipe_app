import 'package:flutter/material.dart';
import 'package:tasty_recipe_app/pages/sign_1_2_login/signin_screen_page.dart';
import 'package:tasty_recipe_app/pages/sign_1_2_login/signup_screen_page.dart';

// todo START PAGE AFTER splash
class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({super.key});

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'images/frying-pan-empty-assorted-spices.jpg',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 140,
                child: Center(
                  child: Image.asset(
                    'images/one.png',
                    scale: 1,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Text(
                'Cooking Done The Easy Way',
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Hellix-RegularItalic',
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 300,
              ),

              // loginButtom = resgister buttom ,
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(17),
                color: Colors.orange[800],
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SignUpScreenPage()),
                    );
                  },
                  child: const Text(
                    'Register',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Hellix-RegularItalic',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 49,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignInScreenPage()));
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white70,
                              fontFamily: 'Hellix-RegularItalic',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ], //children
                    ),
                  ], //children
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
