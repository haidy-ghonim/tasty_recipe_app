import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/models/recipe.model.dart';
import 'package:tasty_recipe_app/pages/filter_page.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/home_first_screen.dart';
import '../provider/recipes.provider.dart';

//todo  recently view
class RecentlyViewedPage extends StatefulWidget {
  const RecentlyViewedPage({
    super.key,
  });

  @override
  State<RecentlyViewedPage> createState() => _RecentlyViewedPageState();
}

class _RecentlyViewedPageState extends State<RecentlyViewedPage> {
  @override
  void initState() {
    Provider.of<FreshRecipesProvider>(context, listen: false)
        .getRecentlyViewRecipe();
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
                MaterialPageRoute(builder: (_) => const HomeFirstScreen()));
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
              .where("recentlyView",
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Recently Viewed",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "LibreBaskerville",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              GestureDetector(
                                //todo clear all
                                child: Text(
                                  "Clear",
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
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (_) =>
                                      //             const SearchPage()));
                                    }, //todo search same thing make
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
                                width: 18.0,
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
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 5, top: 0, right: 5, bottom: 0),
                            child: ListView.builder(
                              itemCount:recipesList.length ,
                              itemBuilder: ( context,  index)=>
                             Container(
                                      height: 150,
                                      width: 80,
                                      //todo todo pppppp
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 0,
                                          right: 15,
                                          bottom: 0),
                                      child: Card(
                                        color: Colors.grey[100],
                                        child: Slidable(
                                          endActionPane: ActionPane(
                                            // key: UniqueKey(),//todo error
                                            motion: const ScrollMotion(),
                                            // dismissible: DismissiblePane(
                                            //     onDismissed: () {}),
                                            children: [
                                              SlidableAction(
                                                onPressed: (context) {
                                                  Provider.of<FreshRecipesProvider>(
                                                          context,
                                                          listen: false)
                                                      .removeRecentlyViewToUser(
                                                          recipesList[index].docId ??'');
                                                },
                                                //todo error
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                icon: Icons.delete,
                                                label: 'Delete',
                                              ),
                                              // SlidableAction(
                                              //   onPressed: noDothing,
                                              //   backgroundColor:
                                              //       const Color(0xFF21B7CA),
                                              //   foregroundColor: Colors.white,
                                              //   icon: Icons.share,
                                              //   label: 'Share',
                                              // ),
                                            ],
                                          ),
                                          child: Container(
                                            // height: 150,
                                            // width: 80,
                                            // margin: const EdgeInsets.only(
                                            //     right: 10.0, top: 5, left: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    recipesList[index].image!,
                                                    height: 120.0,
                                                    width: 100.0,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            //todo name meal type
                                                            Text(
                                                              recipesList[index].mealType!,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Hellix-MediumItalic',
                                                                  fontSize:
                                                                      13.0,
                                                                  color: Colors
                                                                          .cyan[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            const Spacer(),
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                    onTap: () {
                                                                      Provider.of<FreshRecipesProvider>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .addRecipeToUserFavourite(
                                                                          recipesList[index].docId!,
                                                                              isInList(  recipesList[index]));
                                                                      if (isInList(
                                                                          recipesList[index])) {
                                                                        recipesList[index].users_ids?.remove(FirebaseAuth
                                                                            .instance
                                                                            .currentUser
                                                                            ?.uid);
                                                                      } else {}
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    //todo  error heart
                                                                    child: isInList(
                                                                        recipesList[index])
                                                                        ? const Icon(
                                                                            Icons.favorite_border_rounded,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                Colors.grey,
                                                                          )
                                                                        : Icon(
                                                                            Icons.favorite_rounded,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                Colors.orange[900],
                                                                          )),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 2.0,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                recipesList[index].title!,
                                                                maxLines: 1,
                                                                // overflow:
                                                                //     TextOverflow
                                                                //         .ellipsis,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    fontFamily:
                                                                        "LibreBaskerville"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 6.0,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                RatingBar
                                                                    .builder(
                                                                  initialRating:
                                                                      4,
                                                                  minRating: 1,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  updateOnDrag:
                                                                      true,
                                                                  unratedColor:
                                                                      Colors
                                                                          .grey,
                                                                  itemCount: 5,
                                                                  //todo how to give rate
                                                                  itemSize: 15,
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                            .orange[
                                                                        900],
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    // print(rating);
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                  width: 8.0,
                                                                ),
                                                                Text(
                                                                  "${  recipesList[index].calories!}  Calories",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .orange[
                                                                          900],
                                                                      fontSize:
                                                                          14.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 6.0,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.access_time,
                                                              color: Colors
                                                                  .grey[400],
                                                              size: 19.0,
                                                            ),
                                                            const SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Text(
                                                              "${  recipesList[index].totalTime.toString()} mins",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]),
                                                            ),
                                                            const SizedBox(
                                                              width: 16.0,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .room_service_outlined,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                  size: 19.0,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5.0,
                                                                ),
                                                                Text(
                                                                  "${  recipesList[index].serving.toString()} Serving",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10.0,
                                                                      color: Colors
                                                                              .grey[
                                                                          500]),
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
                                    ),
                                  )
                              //     .toList(),
                            ),
                          ),
                        // ),
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
