// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:tasty_recipe_app/models/recipe.model.dart';
//
// class RecommendRecipesProvider extends ChangeNotifier {
//   List<RecipeModel>? _recipesList;
//
//   List<RecipeModel>? get recommendedList => _recipesList;
//   int sliderIndex = 0;
//
//   Future<void> getRecommendRecipes() async {
//     try {
//       var result = await FirebaseFirestore.instance
//           .collection('recommend_recipes')
//           .where('isActive', isEqualTo: true)
//           .get();
//
//       if (result.docs.isNotEmpty) {
//         _recipesList = List<RecipeModel>.from(result.docs
//             .map((doc) => RecipeModel.fromJson(doc.data(), doc.id)));
//       } else {
//         _recipesList = []; //send list empty
//       }
//       notifyListeners();
//     } catch (e) {
//       _recipesList = [];
//       notifyListeners();
//     }
//   }

  // List<RecipeModel>? _favouriteList;
  //
  // List<RecipeModel>? get favouriteList => _favouriteList;
  // Future<void> getIngredient() async {
  //   try {
  //     var result = await FirebaseFirestore.instance
  //         .collection('today_recipes')
  //         .where('users_ids', arrayContains:FirebaseAuth.instance.currentUser?.uid )
  //         .get();
  //     if (result.docs.isNotEmpty) {
  //       _favouriteList = List<RecipeModel>.from(
  //           result.docs.map((doc) =>
  //               RecipeModel.fromJson(doc.data(), doc.id)));
  //       notifyListeners();
  //     } else {
  //       _favouriteList = []; //send list empty
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     _favouriteList = [];
  //     notifyListeners();
  //   }
  // }
  //
  //
  //
  // Future<void> addIngredientToUser(String ingredientId, bool isAdd) async {
  //   try {
  //     OverlayLoadingProgress.start();
  //     if (isAdd) {
  //       await FirebaseFirestore.instance
  //           .collection('today_recipes')
  //           .doc(ingredientId)
  //           .update({
  //         "users_ids":
  //         FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
  //       });
  //     } else {
  //       await FirebaseFirestore.instance
  //           .collection('today_recipes')
  //           .doc(ingredientId)
  //           .update({
  //         "users_ids":
  //         FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
  //       });
  //     }
  //     OverlayLoadingProgress.stop();
  //     getIngredient();
  //   } catch (e) {
  //     OverlayLoadingProgress.stop();
  //     OverlayToastMessage.show(
  //       widget: ToastMessageWidget(
  //         message: 'Error : ${e.toString()}',
  //         toastMessageStatus: ToastMessageStatus.failed,
  //       ),
  //     );
  //   }
//   }
// }
