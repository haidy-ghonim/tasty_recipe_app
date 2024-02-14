import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/provider/app_auth.provider.dart';
import 'package:tasty_recipe_app/widgets/toast_message.widget.dart';

import '../../utils/toast_message_status.dart';

class ForgetPassWordEmailScreen extends StatefulWidget {
  const ForgetPassWordEmailScreen({super.key});

  @override
  State<ForgetPassWordEmailScreen> createState() =>
      _ForgetPassWordEmailScreenState();
}

class _ForgetPassWordEmailScreenState extends State<ForgetPassWordEmailScreen> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).providerInit();
    super.initState();
  }

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
                  child: Consumer<AppAuthProvider>(
                    builder: (context, authProvider, _) => Form(
                      key: authProvider.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: authProvider.emailController,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.indigo,
                            textInputAction: TextInputAction.done,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            // keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              if (email == null || (email?.isEmpty ?? false)) {
                                return 'email is required';
                              }
                              if (!EmailValidator.validate(email)) {
                                return 'Not Valid Email';
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              label: const Text("E-mail"),
                              hintText: 'email',
                              prefixIcon:
                                  const Icon(Icons.mail_outline_rounded),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                              onPressed: ()async {
                                try{
                                await FirebaseAuth.instance.sendPasswordResetEmail(
                                    email: authProvider.emailController!.text.trim());
                                OverlayToastMessage.show(
                                  widget: const ToastMessageWidget(
                                    message: 'Password Reset Email Sent',
                                    toastMessageStatus: ToastMessageStatus.success,
                                  ),
                                );}
                                    on FirebaseAuth catch (e){
                                  print(e);}
                              },
                              child: const Text('Send Verification Email')),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );



  }
}
