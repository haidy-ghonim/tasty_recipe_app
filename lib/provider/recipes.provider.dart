import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:tasty_recipe_app/models/recipe.model.dart';
import 'package:tasty_recipe_app/utils/toast_message_status.dart';
import 'package:tasty_recipe_app/widgets/toast_message.widget.dart';

class FreshRecipesProvider extends ChangeNotifier {
//see all //recipes how masmaha kadaa
  List<RecipeModel>? _allList;
  List<RecipeModel>? get allList => _allList;
  Future<void> getAllRecipes() async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes').get();
      if (result.docs.isNotEmpty) {
        _allList = List<RecipeModel>.from(
            result.docs.map((doc) => RecipeModel.fromJson(doc.data(), doc.id)));
      } else {
        _allList = []; //send list empty
      }
      notifyListeners();
    } catch (e) {
      _allList = [];
      notifyListeners();
    }
  }

  //****************
  //two action make in all and out
  Future<void> addRecipeToUserFavourite(String recipeId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "users_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "users_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      await _updateRecipe(recipeId);
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(
          message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }

  Future<void> _updateRecipe(String recipeId) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .get();
      RecipeModel? updatedRecipe;
      if (result.data() != null) {
        updatedRecipe = RecipeModel.fromJson(result.data()!, result.id);
      } else {
        return;
      }

      var recipesListIndex =
          allList?.indexWhere((recipe) => recipe.docId == recipeId);

      if (recipesListIndex != -1) {
        allList?.removeAt(recipesListIndex!);
        allList?.insert(recipesListIndex!, updatedRecipe);
      }

      var freshRecipesListIndex =
          freshList?.indexWhere((recipe) => recipe.docId == recipeId);

      if (freshRecipesListIndex != -1) {
        freshList?.removeAt(freshRecipesListIndex!);
        freshList?.insert(freshRecipesListIndex!, updatedRecipe);
      }

      var recommandedRecipesListIndex =
          recommendedList?.indexWhere((recipe) => recipe.docId == recipeId);

      if (recommandedRecipesListIndex != -1) {
        recommendedList?.removeAt(recommandedRecipesListIndex!);
        recommendedList?.insert(recommandedRecipesListIndex!, updatedRecipe);
      }

      notifyListeners();
    } catch (e) {
      print('>>>>>error in update recipe');
    }
  }

  //***************
//fresh
  List<RecipeModel>? _freshList;
  List<RecipeModel>? get freshList => _freshList;
  int sliderIndex = 0;
  Future<void> getFreshRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('isActive', isEqualTo: false)
          .limit(10)
          .get();

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

//****************
  //recommended
  List<RecipeModel>? _recommendedList;
  List<RecipeModel>? get recommendedList => _recommendedList;
  Future<void> getRecommended() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('isActive', isEqualTo: true)
          .get();
      if (result.docs.isNotEmpty) {
        _recommendedList = List<RecipeModel>.from(
            result.docs.map((doc) => RecipeModel.fromJson(doc.data(), doc.id)));
        notifyListeners();
      } else {
        _recommendedList = []; //send list empty
      }
      notifyListeners();
    } catch (e) {
      _recommendedList = [];
      notifyListeners();
    }
  }

//****************
//add ingredient
  Future<void> addIngredientToUser(String ingredientId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(ingredientId)
            .update({
          "users_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(ingredientId)
            .update({
          "users_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      OverlayLoadingProgress.stop();
      // getIngredient();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(
          message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }
//****************
}
