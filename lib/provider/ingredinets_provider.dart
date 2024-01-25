// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:overlay_kit/overlay_kit.dart';
// import 'package:tasty_recipe_app/models/ingredinet.model.dart';
// import 'package:tasty_recipe_app/pages/utils/toast_message_status.dart';
// import 'package:tasty_recipe_app/widgets/toast_message.widget.dart';
//
// class IngredientsProvider extends ChangeNotifier {
//   List<IngredientModel>? ingredientsList;
//   int sliderIndex = 0;
//
//   List<IngredientModel>? get ingredients => ingredientsList;
//   Future<void> getIngredient() async {
//     try {
//       var result = await FirebaseFirestore.instance
//           .collection('ingredients')
//           // .where('isActive', isEqualTo: true) //todo
//           .get();
//       if (result.docs.isNotEmpty) {
//         ingredientsList = List<IngredientModel>.from(
//             result.docs.map((doc) =>
//                 IngredientModel.fromJson(doc.data(), doc.id)));
//         notifyListeners();
//       } else {
//         ingredientsList = []; //send list empty
//       }
//       notifyListeners();
//     } catch (e) {
//       ingredientsList = [];
//       notifyListeners();
//     }
//   }
//
//   Future<void> addIngredientToUser(String ingredientId, bool isAdd) async {
//     try {
//       OverlayLoadingProgress.start();
//       if (isAdd) {
//         await FirebaseFirestore.instance
//             .collection('ingredients')
//             .doc(ingredientId)
//             .update({
//           "users_ids":
//           FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
//         });
//       } else {
//         await FirebaseFirestore.instance
//             .collection('ingredients')
//             .doc(ingredientId)
//             .update({
//           "users_ids":
//           FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
//         });
//       }
//       OverlayLoadingProgress.stop();
//       getIngredient();
//     } catch (e) {
//       OverlayLoadingProgress.stop();
//       OverlayToastMessage.show(
//         widget: ToastMessageWidget(
//           message: 'Error : ${e.toString()}',
//           toastMessageStatus: ToastMessageStatus.failed,
//         ),
//       );
//     }}}