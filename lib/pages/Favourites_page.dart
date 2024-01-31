import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/pages/filter_page.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/home_first_screen.dart';
import 'package:tasty_recipe_app/provider/fresh_recipes.provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  bool value = true;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await Provider.of<FreshRecipesProvider>(context, listen: false)
        .getIngredient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (_) => const HomeFirstScreen()
            ));
          },
          icon: const Icon(
            Icons.sort,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12.0,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, top: 10, right: 0, bottom: 0),
                  child: Text(
                    "Favourites",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "LibreBaskerville",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 0, right: 15, bottom: 0),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, top: 0, right: 15, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 3.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextField(
                        cursorColor: Colors.grey[500],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 18.0,
                          ),
                          hintText: "Search using Keywords",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FilterScreenPage())),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 14.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: const Icon(Icons.tune_rounded)),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
