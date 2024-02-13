import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgetPassWordEmailScreen extends StatefulWidget {
  const ForgetPassWordEmailScreen({super.key});

  @override
  State<ForgetPassWordEmailScreen> createState() =>
      _ForgetPassWordEmailScreenState();
}

class _ForgetPassWordEmailScreenState extends State<ForgetPassWordEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.network(
                      'https://lottie.host/64859ed4-741c-42c0-98ec-d3f283946ab1/pjOTYTtyfi.json'),
                ),
                const SizedBox(height: 3),
                Text('Forget Password',
                    style: Theme.of(context).textTheme.headlineMedium),
                Text(
                  'select one of the options given below  to reset your password',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 7),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blueGrey,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        label: const Text("E-mail"),
                        hintText: 'email',
                        prefixIcon: const Icon(Icons.mail_outline_rounded),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text('Next')),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
