import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasty_recipe_app/models/ad.model.dart';

class AdsProvider extends ChangeNotifier {
  List<Ad> _ads = [];

  List<Ad> get ads => _ads;

  void getAds() async {
    // emit(AdsLoading());
    await Future.delayed(const Duration(seconds: 1));
    var adsData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
    List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
    _ads = dataDecoded.map((e) => Ad.fromJson(e)).toList();
    notifyListeners();
  }
}
