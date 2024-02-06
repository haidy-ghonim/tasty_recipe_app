import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/pages/Favourites_page.dart';
import 'package:tasty_recipe_app/pages/ingredient_page.dart';
import 'package:tasty_recipe_app/pages/recently.viewed_page.dart';
import 'package:tasty_recipe_app/pages/settings_page.dart';
import 'package:tasty_recipe_app/provider/app_auth.provider.dart';

//todo menu screen
class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/girl.jpg'),
            radius: 50,
          ),
        ),
        centerTitle: true,
        title: const Column(
          children: [
            ListTile(
              title: Text(
                'Emman Holmes',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Hellix-Light'),
              ),
              subtitle: Text(
                'View Profile',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 2),
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text('Home'),
            ),
            ListTile(
                leading: const Icon(
                  Icons.favorite_border,
                  // size: 30,
                ),
                title: const Text('Favourites'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FavouritesPage()));
                }),
            ListTile(
              leading: const Icon(
                Icons.fastfood_sharp,
              ),
              title: const Text('Ingredients'),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const IngredientPage())),
            ),
            ListTile(
              leading: const Icon(
                Icons.play_arrow_outlined,
              ),
              title: const Text('Recently Viewed'),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const RecentlyViewedPage())),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text('Settings'),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage())),
            ),
            ListTile(
              leading: const Icon(
                Icons.error_outline,
              ),
              title: const Text('About Us'), //todo
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.help_outline,
              ),
              title: const Text('Help'), //todo
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
              ),
              title: const Text('Sign Out'),
              onTap: () {
                Provider.of<AppAuthProvider>(context, listen: false)
                    .signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
