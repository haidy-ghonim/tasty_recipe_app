import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:lottie/lottie.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 90, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 280,
                    child: Lottie.network(
                        // 'https://lottie.host/6179f512-0c97-4564-93f0-d0ded5607a4f/uZW1JG8vMN.json'
                        'https://lottie.host/90607297-3e65-4975-8e18-fe1278bd956d/5pTeKEQ9on.json'),
                  ),
                ),
                const SizedBox(height: 60),
                Center(
                  child: Text('Verification Code',
                      style: Theme.of(context).textTheme.headlineLarge),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Enter Your Messange Code',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(height: 20),
                OtpTextField(
                  numberOfFields: 4,
                  fillColor: Colors.black38.withOpacity(0.1),
                  filled: true,
                  onSubmit: (code) {
                    print("ok is => $code");
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Material(
                    // elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange[600],
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      onPressed: otpCode.isNotEmpty
                          ? () async {
                              // await _provider.verifyOTP(otpCode, context);
                            }
                          : null,
                      child: const Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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
