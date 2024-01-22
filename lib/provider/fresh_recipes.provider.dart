//read only in  firebase //e= doc
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasty_recipe_app/models/ad.model.dart';
import 'package:tasty_recipe_app/models/recipe.model.dart';

class FreshRecipesProvider extends ChangeNotifier {

  List<RecipeModel>? _freshList;

  List<RecipeModel>? get freshList => _freshList;
  int sliderIndex = 0;

  // CarouselController? carouselController;

  // var freshList =
  // void onPageChanged(int index ,String['image']) {
  //   freshList = index as List<Ad>?;
  //   notifyListeners();
  // }

  // void onDotTappedRow(int position) async {
  //   await carouselController?.animateToPage(position);
  //   sliderIndex = position;
  //   notifyListeners();
  // }
  //
  // void disposedCarousel (){
  //   carouselController =null;
  // }
  // void initCarousel() {
  //   carouselController = CarouselController();
  // }

  Future<void> getTodayRecipes() async {

    try {
      var result = await FirebaseFirestore.instance.collection('today_recipes').get();

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
}