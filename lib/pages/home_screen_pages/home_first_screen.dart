import 'package:flutter/material.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/drawer_screen.dart';

//home gaged
class HomeFirstScreen extends StatefulWidget {
  const HomeFirstScreen({super.key});

  @override
  State<HomeFirstScreen> createState() => _HomeFirstScreenState();
}

class _HomeFirstScreenState extends State<HomeFirstScreen> {
  //appbar
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawerScreen(),
    );
  }
}
