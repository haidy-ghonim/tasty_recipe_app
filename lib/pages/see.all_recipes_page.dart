//see all Recipe screen
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/provider/recipes.provider.dart';

class AllRecipesPage extends StatefulWidget {
  const AllRecipesPage({super.key});
  @override
  State<AllRecipesPage> createState() => _AllRecipesPageState();
}

class _AllRecipesPageState extends State<AllRecipesPage> {
  final int _currentPosition = 0;
  String getPrettyCurrPosition() {
    return (_currentPosition + 1.0).toStringAsPrecision(3);
  }

  bool favorite = true;
  void toggleFavorite() {
    favorite = !favorite;
    setState(() {});
  }

  @override
  void initState() {
    Provider.of<FreshRecipesProvider>(context, listen: false).getAllRecipes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<FreshRecipesProvider>(
        builder: (context, freshRecipesProvide, _) => freshRecipesProvide
                    .allList ==
                null
            ? const CircularProgressIndicator()
            : (freshRecipesProvide.allList?.isEmpty ?? false)
                ? const Text('NO DATA FOUND')
                : FlexibleGridView(
                    children: freshRecipesProvide.allList!
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
                                  borderRadius: BorderRadius.circular(15.0),
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Positioned(
                                            // top: 6,
                                            // left: 7,
                                            child: InkWell(
                                              onTap: () {
                                                toggleFavorite();
                                              },
                                              child: (favorite
                                                  ? const Icon(
                                                      Icons
                                                          .favorite_border_rounded,
                                                      size: 30,
                                                      color: Colors.grey,
                                                    )
                                                  : Icon(
                                                      Icons.favorite_rounded,
                                                      size: 30,
                                                      color: Colors.orange[900],
                                                    )),
                                            ),
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
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
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
                                                      style: const TextStyle(
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
                                              itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.orange[900]),
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
                                                  color: Colors.orange[900],
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400),
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
                                                      color: Colors.grey[500]),
                                                ),
                                                // const SizedBox(
                                                //   width: 16.0,
                                                // ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .room_service_outlined,
                                                      color: Colors.grey[400],
                                                      size: 19.0,
                                                    ),
                                                    const SizedBox(
                                                      width: 3.0,
                                                    ),
                                                    Text(
                                                      "${e.serving.toString()} Serving",
                                                      style: TextStyle(
                                                        fontSize: 10.0,
                                                        color: Colors.grey[500],
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
    );
  }
}
