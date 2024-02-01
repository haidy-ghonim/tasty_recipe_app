import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/pages/sign_1_2_login/signin_screen_page.dart';
import 'package:tasty_recipe_app/provider/app_auth.provider.dart';

//resgister page
class SignUpScreenPage extends StatefulWidget {
  const SignUpScreenPage({super.key});

  @override
  State<SignUpScreenPage> createState() => _SignUpScreenPageState();
}

class _SignUpScreenPageState extends State<SignUpScreenPage> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).providerInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // width: double.infinity,
            // height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'images/frying-pan-empty-assorted-spices.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
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
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Hellix-RegularItalic',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 25,
                            ),

                            //person
                            TextFormField(
                              controller: authProvider.firstnameController,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                              // validator: (){},
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.grey,
                                ),
                                // contentPadding:
                                //     EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "First Name",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //  emailField
                            TextFormField(
                              controller: authProvider.emailController,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    (value?.isEmpty ?? false)) {
                                  return 'email is required';
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
                                hintStyle: const TextStyle(color: Colors.grey),
                                hintText: "E-Mail",
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),

                            //passwordField
                            TextFormField(
                              controller: authProvider.passwordController,
                              obscureText: authProvider.obsecureText,
                              style: const TextStyle(color: Colors.white),
                              autovalidateMode: AutovalidateMode.always,
                              // autofocus: true,
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
                                hintStyle: const TextStyle(color: Colors.grey),
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
                              height: 60,
                            ),
                            //signUPButtom = Register
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.orange[800],
                              child: MaterialButton(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  await authProvider.signUp(context);
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder:
                                  //           // SIgNIN  HATABAHAA
                                  //           (_) => const HomeFirstScreen()),
                                  // );
                                },
                                child: const Text(
                                  'Register',
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

                            const SizedBox(
                              height: 30,
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
                                    // 'https://lottie.host/0785019d-c827-40c3-b4d7-e60d7775f3d8/lxGbFlPDQA.json',
                                    'https://lottie.host/61cb0dff-ab4c-4056-9205-fe331421538f/ChJMUbcauq.json',
                                    // height: 40,
                                    width: 60,
                                  ),
                                ],
                              ),
                            ),



                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Already registered?',
                                  style: TextStyle(
                                    fontFamily: 'Hellix-RegularItalic',
                                    fontSize: 15,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                //LOGIN
                                                const SignInScreenPage()));
                                  },
                                  child: Text(
                                    'Sign in.',
                                    style: TextStyle(
                                        fontFamily: 'Hellix-RegularItalic',
                                        color: Colors.orange[900],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
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
    );
  }
}
