
import 'package:flutter/material.dart';
//todo law 3awza a3amal animation wa5atather fe 3adaa el buttom
abstract class NavigationUtils {
  static push({required BuildContext context, required Widget page}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
