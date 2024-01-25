import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/main_screen_page.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/menu_screen.dart';

// lafaa
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key,});
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final zoomDrawerControllor = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: ZoomDrawer(
        controller: zoomDrawerControllor,
        menuScreen: const MenuScreen(),
        mainScreen:
        const MainScreen(),
        showShadow: true,
        borderRadius: 30,
        // drawerShadowsBackgroundColor: Colors.teal,
        shadowLayer1Color: Colors.grey[200],
        shadowLayer2Color: Colors.grey[400],
        // menuBackgroundColor: Colors.purple, //todo
        // style: DrawerStyle.style4,
      ),
    );
  }
}
