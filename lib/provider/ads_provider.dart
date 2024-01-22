import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasty_recipe_app/models/ad.model.dart';

//read only in  firebase //e= doc
class AdsProvider extends ChangeNotifier {
  List<Ad>? adsList;

  List<Ad>? get ads => adsList;
  int sliderIndex = 0;
  CarouselController? carouselController;

  void onPageChanged(int index) {
    sliderIndex = index;
    notifyListeners();
  }

  void onDotTappedRow(int position) async {
    await carouselController?.animateToPage(position);
    sliderIndex = position;
    notifyListeners();
  }

  void disposedCarousel (){
    carouselController =null;
  }
  void initCarousel() {
    carouselController = CarouselController();
  }

  Future<void> getAds() async {
    try {
      var result = await FirebaseFirestore.instance.collection('ads').get();

      if (result.docs.isNotEmpty) {
        adsList = List<Ad>.from(
            result.docs.map((doc) => Ad.fromJson(doc.data(), doc.id)));
      } else {
        adsList = []; //send list empty
      }
      notifyListeners();
    } catch (e) {
      adsList = [];
      notifyListeners();
    }
  }
}









// class AdsProvider extends ChangeNotifier {
//   List<Ad> _ads = [];
//
//   List<Ad> get ads => _ads;
//
//   void getAds() async {
//     // emit(AdsLoading());
//     await Future.delayed(const Duration(seconds: 1));
//     var adsData = await rootBundle.loadString('assets/data/sample.json');
//     var dataDecoded =
//     List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
//     _ads = dataDecoded.map((e) => Ad.fromJson(e)).toList();
//     notifyListeners();
//   }
// }
