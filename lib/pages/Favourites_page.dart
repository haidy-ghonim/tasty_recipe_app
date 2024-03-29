import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/models/recipe.model.dart';
import 'package:tasty_recipe_app/pages/filter_page.dart';
import 'package:tasty_recipe_app/pages/recently_viewed_page.dart';
import 'package:tasty_recipe_app/provider/recipes.provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  bool isSearching = false;
  final _favouriteController = TextEditingController();
  List<RecipeModel> recipesFavourite = [];
  List<RecipeModel> recipesList = [];

  @override
  void initState() {
    super.initState();
  }

  bool isInList(RecipeModel recipe) {
    return recipe.users_ids!.contains(FirebaseAuth.instance.currentUser?.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const RecentlyViewedPage()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.network(
                'https://lottie.host/f15ed9f6-df3a-4fe5-854d-c61951d77a28/rMnQwRRxX0.json'),
          ),
          const SizedBox(
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
                  List<RecipeModel> recipesList = snapshots.data?.docs
                      .map((e) => RecipeModel.fromJson(e.data(), e.id))
                      .toList() ??
                      [];

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 6.0,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, top: 5, right: 0, bottom: 0),
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
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  child: TextField(
                                    controller: _favouriteController,
                                    onChanged: (value) {
                                      final result = recipesList
                                          .where((e) => e.title!
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                          .toList();
                                      recipesFavourite = result;
                                      // searchFromFirebase(value);
                                      print(
                                          "oopopoplpl78880jihugggffffffffeee");
                                      print(result);
                                    },
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
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14.0),
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
                            controller: ScrollController(),
                            // physics: NeverScrollableScrollPhysics(),
                            children: recipesList
                                .map(
                                  (e) => Container(
                                    height: 340,
                                    padding: const EdgeInsets.only(
                                        left: 5, top: 0, right: 5, bottom: 0),
                                    //todo animation of card
                                    child: Card(
                                      elevation: 2,
                                      child: Container(
                                        height: 400,
                                        width: 210,
                                        margin: const EdgeInsets.only(
                                            right: 10.0, left: 10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
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
                                                                        .orange[
                                                                    900],
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
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              //todo bafakera akafalha
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
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      updateOnDrag: true,
                                                      unratedColor: Colors.grey,
                                                      itemCount: 5,
                                                      //todo how to give rate
                                                      itemSize: 15,
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                              Icons.star,
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
                                                          color: Colors
                                                              .orange[900],
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
                                                          color:
                                                              Colors.grey[400],
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
