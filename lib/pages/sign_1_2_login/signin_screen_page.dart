import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/pages/sign_1_2_login/signup_screen_page.dart';
import 'package:tasty_recipe_app/provider/app_auth.provider.dart';

//login in
class SignInScreenPage extends StatefulWidget {
  const SignInScreenPage({super.key});

  @override
  State<SignInScreenPage> createState() => _SignInScreenPageState();
}

class _SignInScreenPageState extends State<SignInScreenPage> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).providerInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/frying-pan-empty-assorted-spices.jpg',
                  ),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black54, BlendMode.darken),
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Consumer<AppAuthProvider>(
                        builder: (context, authProvider, _) => Form(
                          key: authProvider.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                'Sign In',
                                style: TextStyle(
                                    fontFamily: 'Hellix-RegularItalic',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),

                              // emailField,

                              TextFormField(
                                controller: authProvider.emailController,
                                style: const TextStyle(color: Colors.white),
                                // autofocus: true,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null ||
                                      (value?.isEmpty ?? false)) {
                                    return 'email is required';
                                  }
                                  if (!EmailValidator.validate(value)) {
                                    return 'Not Valid Email';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.grey[500],
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  hintText: "E-Mail",
                                  filled: true,
                                  fillColor: Colors.transparent,
                                ),
                              ),

                              const SizedBox(
                                height: 15,
                              ),
                              //passwordField
                              TextFormField(
                                controller: authProvider.passwordController,
                                obscureText: authProvider.obsecureText,
                                style: const TextStyle(color: Colors.white),
                                validator: (value) {
                                  if (value == null ||
                                      (value?.isEmpty ?? false)) {
                                    return 'password is required';
                                  }
                                  if (value.length < 6) {
                                    return 'password is too short';
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey[500],
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  hintText: "Password",
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  suffixIcon: InkWell(
                                    onTap: () => authProvider.toggleObsecure(),
                                    child: Icon(
                                      authProvider.obsecureText
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              //todo firbase forgot password
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontFamily: 'Hellix-RegularItalic',
                                      fontSize: 15,
                                      color: Colors.cyan[700],
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),

                              const SizedBox(
                                height: 70,
                              ),
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(17),
                                color: Colors.orange[800],
                                child: MaterialButton(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () async {
                                    await authProvider.logIn(context);
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder:
                                    //           //SIgNIN  HATABAHAA
                                    //           (_) => const HomeFirstScreen()),
                                    // );
                                  },
                                  child: const Text(
                                    'Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LottieBuilder.network(
                                      'https://lottie.host/37516613-a142-495d-8cd5-b90aece34349/ZfzFpLuLcO.json',
                                      // height: 60,
                                      width: 60,
                                    ),
                                    LottieBuilder.network(
                                      'https://lottie.host/a8627238-404f-4966-8fa5-4cddcfdc4c91/EDMYUBT5pA.json',
                                      // height: 40,
                                      width: 60,
                                    ),
                                    LottieBuilder.network(
                                      'https://lottie.host/61cb0dff-ab4c-4056-9205-fe331421538f/ChJMUbcauq.json',
                                      // height: 40,
                                      width: 60,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 160,
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Donot have an account?',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                //RegisterPage
                                                builder: (_) =>
                                                    const SignUpScreenPage()));
                                      },
                                      child: Text(
                                        ' Register.',
                                        style: TextStyle(
                                            color: Colors.orange[800],
                                            fontSize: 16),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
