import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/home_first_screen.dart';
import 'package:tasty_recipe_app/pages/splash_screen_page.dart';
import 'package:tasty_recipe_app/utils/toast_message_status.dart';
import 'package:tasty_recipe_app/widgets/toast_message.widget.dart';

class AppAuthProvider extends ChangeNotifier {
  GlobalKey<FormState>? formKey;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? forgetpasswordController;
  TextEditingController? firstnameController;
  TextEditingController? ageController;
  TextEditingController? phoneNumberController;
  bool obsecureText = true;

  void providerInit() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    forgetpasswordController = TextEditingController();
    firstnameController = TextEditingController();
    ageController = TextEditingController();
    phoneNumberController=TextEditingController();
  }

  void providerDispose() {
    emailController = null;
    passwordController = null;
    formKey = null;
    obsecureText = false;
    forgetpasswordController = null;
    firstnameController = null;
    ageController = null;
    phoneNumberController=null;
  }

  void toggleObsecure() {
    obsecureText = !obsecureText;
    notifyListeners();
  }

//****************
//todo  phone

  //****************
//todo upload photo
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> updatePhotoURL(String photoURL) async {
    try {
      // Get the currently authenticated user
      User? user = _firebaseAuth.currentUser;
      // Update the photoURL property of the user
      if (user != null) {
        await user.updatePhotoURL(photoURL);
        // Reload the user to apply the changes
        await user.reload();
      } else {
        // Handle the case when the user is not authenticated
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No authenticated user found.',
        );
      }
      notifyListeners();
    } catch (e) {
      // Handle any errors that occur during the update process
      print('Error updating photo URL: $e');
      throw e;
    }
    notifyListeners();
  }

//****************
//todo login
  Future<void> logIn(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        OverlayLoadingProgress.start();
        var credentials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text);

        if (credentials.user != null) {
          OverlayLoadingProgress.stop();
          providerDispose();
          OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'You Login Successully',
              toastMessageStatus: ToastMessageStatus.success,
            ),
          );

          if (context.mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const HomeFirstScreen()));
          }
        }
        OverlayLoadingProgress.stop();
      }
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
      //email mesh mogawada
      if (e.code == 'user-not-found') {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'user not found',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == 'wrong-password') {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
          message: 'Wrong password provided for that user.',
          toastMessageStatus: ToastMessageStatus.failed,
        ));
      } else if (e.code == "user-disabled") {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
          message: 'This email Account was disabled',
          toastMessageStatus: ToastMessageStatus.failed,
        ));
      } else if (e.code == "invalid-credential") {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
          message: 'invalid-credential',
          toastMessageStatus: ToastMessageStatus.failed,
        ));
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(textMessage: 'Public Error $e');
    }
  }

  //****************
//todo signup
  Future<void> signUp(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        OverlayLoadingProgress.start();
        var credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text);

        if (credentials.user != null) {
          await credentials.user?.updateDisplayName(firstnameController!.text);
          FirebaseAuth.instance.currentUser?.updatePhotoURL('');
          // FirebaseAuth.instance.currentUser?.updateDisplayName('');
          OverlayLoadingProgress.stop();
          providerDispose();

          if (context.mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const HomeFirstScreen()));
          }
        }
        OverlayLoadingProgress.stop();
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
    }
  }

  //****************
//todo signout
  void signOut(BuildContext context) async {
    OverlayLoadingProgress.start();
    await Future.delayed(const Duration(seconds: 1));
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const SplashScreenPage()),
          (route) => false);
    }
    OverlayLoadingProgress.stop();
  }
  //****************
}
