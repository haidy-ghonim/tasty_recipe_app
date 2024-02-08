import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/models/recipe.model.dart';
import 'package:tasty_recipe_app/pages/filter_page.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/home_first_screen.dart';
import 'package:tasty_recipe_app/provider/recipes.provider.dart';

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

  bool isInList(RecipeModel recipe) {
    return recipe.users_ids!.contains(FirebaseAuth.instance.currentUser?.uid);
  }

  void init() async {
    // await Provider.of<FreshRecipesProvider>(context, listen: false)
    //     .getFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const HomeFirstScreen()));
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('recipes')
              .where("users_ids",
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshots.hasError) {
                return const Text('ERROR WHEN GET DATA');
              } else {
                if (snapshots.hasData) {
                  List<RecipeModel> recipesList = snapshots
                          .data?.docs
                          .map((e) => RecipeModel.fromJson(
                              e.data(), e.id))
                          .toList() ??
                      [];
                  return SingleChildScrollView(
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
                              padding: EdgeInsets.only(
                                  left: 20, top: 10, right: 0, bottom: 0),
                              child: Text(
                                "Favourites",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "LibreBaskerville",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 16.0,
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.only(
                        //       left: 20, top: 0, right: 15, bottom: 0),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 0, right: 15, bottom: 0),
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
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 14.0),
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
                                        builder: (_) =>
                                            const FilterScreenPage())),
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
                          height: 10.0,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: FlexibleGridView(
                            // physics: NeverScrollableScrollPhysics(),
                            children: recipesList
                                .map(
                                  (e) => Container(
                                    height: 340,
                                    padding: const EdgeInsets.only(
                                        left: 5, top: 0, right: 5, bottom: 0),
                                    child: Card(
                                      color: Colors.grey[100],
                                      elevation: 2,
                                      child: Container(
                                        height: 400,
                                        width: 210,
                                        margin: const EdgeInsets.only(
                                            right: 10.0, left: 10.0),
                                        decoration: BoxDecoration(
                                          // color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          children: [
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    e.image!,
                                                    fit: BoxFit.cover,
                                                    width: 300,
                                                    height: 150,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Positioned(
                                                    // top: 6,
                                                    // left: 7,
                                                    child: InkWell(
                                                        onTap: () {
                                                          Provider.of<FreshRecipesProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .addRecipeToUserFavourite(
                                                                  e.docId!,
                                                                  isInList(e));
                                                          if (isInList(e)) {
                                                            e.users_ids?.remove(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    ?.uid);
                                                          } else {}
                                                          setState(() {});
                                                        },
                                                        //todo  error heart
                                                        child: isInList(e)
                                                            ? const Icon(
                                                                Icons
                                                                    .favorite_border_rounded,
                                                                size: 30,
                                                                color:
                                                                    Colors.grey,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                size: 30,
                                                                color: Colors
                                                                    .orange[900],
                                                              )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              top: 150,
                                              // left: 20,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 14,
                                                    top: 5,
                                                    right: 10,
                                                    bottom: 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      e.mealType!,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Hellix-MediumItalic',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.cyan[700],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Container(
                                                      width: 300,
                                                      child: Row(
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              e.title!,
                                                              maxLines: 2,
                                                              overflow: TextOverflow
                                                                  .ellipsis, //todo bafakera akafalha
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Hellix-MediumItalic',
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8.0,
                                                    ),
                                                    RatingBar.builder(
                                                      initialRating: 4,
                                                      minRating: 1,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      updateOnDrag: true,
                                                      unratedColor: Colors.grey,
                                                      itemCount:
                                                          5, //todo how to give rate
                                                      itemSize: 15,
                                                      itemBuilder: (context, _) =>
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .orange[900]),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 8.0,
                                                    ),
                                                    Text(
                                                      "${e.calories!}  Calories",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.orange[900],
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    const SizedBox(
                                                      height: 8.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.access_time,
                                                          color: Colors.grey[400],
                                                          size: 19.0,
                                                        ),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                          "${e.totalTime.toString()} mins",
                                                          style: TextStyle(
                                                              fontSize: 10.0,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                        // const SizedBox(
                                                        //   width: 16.0,
                                                        // ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .room_service_outlined,
                                                              color: Colors
                                                                  .grey[400],
                                                              size: 19.0,
                                                            ),
                                                            const SizedBox(
                                                              width: 3.0,
                                                            ),
                                                            Text(
                                                              "${e.serving.toString()} Serving",
                                                              style: TextStyle(
                                                                fontSize: 10.0,
                                                                color: Colors
                                                                    .grey[500],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text('No Data Found');
                }
              }
            }
          }),
    );
  }
}
