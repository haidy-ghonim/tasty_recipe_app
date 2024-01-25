import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:tasty_recipe_app/models/recipe.model.dart';
import 'package:tasty_recipe_app/pages/utils/toast_message_status.dart';
import 'package:tasty_recipe_app/widgets/toast_message.widget.dart';

class FreshRecipesProvider extends ChangeNotifier {
  List<RecipeModel>? _freshList;

  List<RecipeModel>? get freshList => _freshList;
  int sliderIndex = 0;

  Future<void> getTodayRecipes() async {
    try {
      var result =
          await FirebaseFirestore.instance.collection('today_recipes').get();

      if (result.docs.isNotEmpty) {
        _freshList = List<RecipeModel>.from(
            result.docs.map((doc) => RecipeModel.fromJson(doc.data(), doc.id)));
      } else {
        _freshList = []; //send list empty
      }
      notifyListeners();
    } catch (e) {
      _freshList = [];
      notifyListeners();
    }
  }

  List<RecipeModel>? _favouriteList;

  List<RecipeModel>? get favouriteList => _favouriteList;
  Future<void> getIngredient() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('today_recipes')
          .where('users_ids', arrayContains:FirebaseAuth.instance.currentUser?.uid )
          .get();
      if (result.docs.isNotEmpty) {
        _favouriteList = List<RecipeModel>.from(
            result.docs.map((doc) =>
                RecipeModel.fromJson(doc.data(), doc.id)));
        notifyListeners();
      } else {
        _favouriteList = []; //send list empty
      }
      notifyListeners();
    } catch (e) {
      _favouriteList = [];
      notifyListeners();
    }
  }



  Future<void> addIngredientToUser(String ingredientId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('today_recipes')
            .doc(ingredientId)
            .update({
          "users_ids":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('today_recipes')
            .doc(ingredientId)
            .update({
          "users_ids":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      OverlayLoadingProgress.stop();
      getIngredient();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(
          message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }}}
