import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:tasty_recipe_app/pages/filter_page.dart';
//todo  recently

class RecentlyViewedPage extends StatefulWidget {
  const RecentlyViewedPage({super.key});

  @override
  State<RecentlyViewedPage> createState() => _RecentlyViewedPageState();
}

class _RecentlyViewedPageState extends State<RecentlyViewedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "LibreBaskerville",
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Reset All",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: "LibreBaskerville",
                        color: Colors.orange[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, top: 0, right: 15, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1.0,
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(14.0)),
                      child: TextField(
                        onTap: () {}, //todo search same thing make page
                        cursorColor: Colors.grey[500],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 18.0,
                          ),
                          hintText: "Search For Recipes",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
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
