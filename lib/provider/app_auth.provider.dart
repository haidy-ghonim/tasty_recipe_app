import 'package:cloud_firestore/cloud_firestore.dart';
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
  TextEditingController? lastController;
  TextEditingController? ageController;
  TextEditingController? phonenumberController;
  bool obsecureText = true;

  void providerInit() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    forgetpasswordController = TextEditingController();
    phonenumberController = TextEditingController();
    firstnameController = TextEditingController();
    lastController = TextEditingController();
    ageController = TextEditingController();
  }

  void providerDispose() {
    emailController = null;
    passwordController = null;
    formKey = null;
    obsecureText = false;
    forgetpasswordController = null;
    phonenumberController = null;
    firstnameController = null;
    lastController = null;
    ageController = null;
  }

  void toggleObsecure() {
    obsecureText = !obsecureText;
    notifyListeners();
  }

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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> updatePhotoURL(String photoURL) async {
    try {
      User? user = _firebaseAuth.currentUser;

      // await user?.updateProfile(photoURL: photoURL);
await FirebaseAuth.instance.currentUser?.updatePhotoURL
  ('https://firebasestorage.googleapis.com/v0/b/tasty-food-app-e53e9.appspot.com/o/profile%2FFB_IMG_1707067893374.jpg?alt=media&token=97ba6522-3318-4cfb-a567-a7691d4b82a3');
      // Reload the user to get the updated information
      await user?.reload();
      user = _firebaseAuth.currentUser;

      print('PhotoURL updated successfully');
    } catch (e) {
      print('Error updating PhotoURL: $e');
    }
  }

//todo new user
  Future addUserDetails() async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': '',
      'last name': '',
      'age': '',
      'phone number':'',
    });
  }

  // Future updateUserProfile(User user, String newUsername) async {
  //   await _firestore.collection('users').doc(user.uid).update({
  //     'username': newUsername,
  //   });
  //
  // Future uploadProfilePicture(User user, File profilePicture) async {
  //   final FirebaseStorage _storage = FirebaseStorage.instance;
  //
  //   UploadTask uploadTask = _storage
  //       .ref()
  //       .child('userProfilePictures/${user.uid}/profilePicture.jpg')
  //       .putFile('profilePicture' as File);
  //
  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  //   String downloadURL = await taskSnapshot.ref.getDownloadURL();
  //
  //   return downloadURL;
  // }
}
