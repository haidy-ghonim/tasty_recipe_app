//inside taste food page
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/models/ingredient.model.dart';
import 'package:tasty_recipe_app/models/recipe.model.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/home_first_screen.dart';
import 'package:tasty_recipe_app/provider/recipes.provider.dart';

class DetailsScreen extends StatefulWidget {
  final RecipeModel recipe;
  const DetailsScreen({super.key, required this.recipe //todo error
      });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    Provider.of<FreshRecipesProvider>(context, listen: false)
        .getSelectedRecipe(widget.recipe.docId!);
    super.initState();
  }

  bool get isInList => (widget.recipe.users_ids!
      .contains(FirebaseAuth.instance.currentUser?.uid));

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  widget.recipe.title ?? '',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: "LibreBaskerville",
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                trailing: InkWell(
                    onTap: () {
                      Provider.of<FreshRecipesProvider>(context, listen: false)
                          .addRecipeToUserFavourite(
                              widget.recipe.docId!, isInList);
                      if (isInList) {
                        widget.recipe.users_ids
                            ?.remove(FirebaseAuth.instance.currentUser?.uid);
                      } else {
                        widget.recipe.users_ids
                            ?.add(FirebaseAuth.instance.currentUser!.uid);
                      }
                      setState(() {});
                    },
                    child: isInList
                        ? const Icon(
                            Icons.favorite_border_rounded,
                            size: 30,
                            color: Colors.grey,
                          )
                        : Icon(
                            Icons.favorite_rounded,
                            size: 30,
                            color: Colors.orange[900],
                          )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                    child: Text(
                      widget.recipe.mealType ?? '',
                      style: TextStyle(
                        fontFamily: 'Hellix-MediumItalic',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: Colors.cyan[700],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // todo Calories
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                '${widget.recipe.calories ?? ''}  Calories',
                                style: TextStyle(
                                    color: Colors.orange[900],
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),

                            //todo RatingBar
                            RatingBar.builder(
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              updateOnDrag: true,
                              unratedColor: Colors.grey,
                              itemCount: 5, //todo how to give rate
                              itemSize: 15,
                              itemBuilder: (context, _) =>
                                  Icon(Icons.star, color: Colors.orange[900]),
                              onRatingUpdate: (rating) {
                                // print(rating);
                              },
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),

                            //todo mins
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey[400],
                                  size: 19.0,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                  height: 5.0,
                                ),
                                Text(
                                  "${widget.recipe.totalTime.toString() ?? ''} mins ",
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey[500]),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5.0,
                              height: 5.0,
                            ),

                            //todo  Serving
                            Row(
                              children: [
                                Icon(
                                  Icons.room_service_outlined,
                                  color: Colors.grey[400],
                                  size: 19.0,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                  height: 5.0,
                                ),
                                Text(
                                  "${widget.recipe.serving.toString() ?? ''} Serving",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.recipe.image ?? '',
                                fit: BoxFit.cover,
                                height: 180,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //todo ingredients
                  ListTile(
                    title: const Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "LibreBaskerville",
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    subtitle: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('ingredients')
                            .where('users_ids',
                                arrayContains:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .get(),
                        builder: (context, snapShot) {
                          if (snapShot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            var userIngredients = List<Ingredient>.from(snapShot
                                .data!.docs
                                .map((e) => Ingredient.fromJson(e.data(), e.id))
                                .toList());

                            var userIngredientsTitles =
                                userIngredients.map((e) => e.name).toList();
                            Widget checkIngredientWidget(
                                String recipeIngredient) {
                              bool isExsist = false;
                              for (var userIngredientsTitle
                                  in userIngredientsTitles) {
                                if (recipeIngredient
                                    .contains(userIngredientsTitle!)) {
                                  isExsist = true;
                                  break;
                                } else {
                                  isExsist = false;
                                }
                              }

                              if (isExsist) {
                                return const Icon(Icons.check);
                              } else {
                                return const Icon(Icons.close);
                              }
                            }

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widget.recipe.ingredients
                                        ?.map((e) => Row(
                                              children: [
                                                Text(e),
                                                checkIngredientWidget(e)
                                              ],
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            );
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 24.0,
                    width: 10,
                  ),
                  ListTile(
                    title: const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "LibreBaskerville",
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    subtitle: Padding(
                      padding:  const EdgeInsets.fromLTRB(5,10,0,8),
                      child: Text(
                        widget.recipe.description.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontFamily: "LibreBaskerville",
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //todo direction
                  ListTile(
                    title:  const Text(
                      'Direction',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "LibreBaskerville",
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    subtitle: Padding(
                      padding:  const EdgeInsets.fromLTRB(5,10,0,8),
                      child: Text(
                        widget.recipe.directions!.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: "LibreBaskerville",
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: kDefaultIconLightColor,
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: SingleChildScrollView(
          child: Container(
            height: 58.0,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(
              color: Colors.orange[900],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28.0),
                topRight: Radius.circular(28.0),
              ),
            ),
            child: Text(
              "BACK",
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: "DancingScript",
                color: kDefaultIconLightColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
