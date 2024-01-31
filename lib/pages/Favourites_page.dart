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

            // todo favourite all wrong code

            // Consumer<FreshRecipesProvider>(
            //     builder: (context, ingredientsProvider, _) =>
            //         ingredientsProvider.freshList == null
            //             ? const CircularProgressIndicator()
            //             : (ingredientsProvider.freshList?.isEmpty ?? false)
            //                 ? const Text('NO DATA FOUND')
            //                 : ListView.builder(
            //                     physics: const NeverScrollableScrollPhysics(),
            //                     shrinkWrap: true,
            //                     itemCount:
            //                         ingredientsProvider.freshList!.length,
            //                     padding: EdgeInsets.zero,
            //                     itemBuilder: (context, index) {
            //                       // ingredientsProvider
            //                       //    .favouriteList![index]
            //                       //    .users_ids
            //                       //    ?.contains(FirebaseAuth
            //                       //    .instance.currentUser?.uid);
            //
            //                       return Container(
            //                         padding: const EdgeInsets.symmetric(
            //                             horizontal: 13),
            //                         margin: const EdgeInsets.only(
            //                             right: 10.0, top: 10, left: 10),
            //                         decoration: BoxDecoration(
            //                             color: Colors.grey[200],
            //                             borderRadius:
            //                                 BorderRadius.circular(10)),
            //                         child: Row(
            //                           children: [
            //                             Image.network(
            //                               ingredientsProvider
            //                                   .freshList![index].image!,
            //                               height: 150.0,
            //                               width: 120.0,
            //                               fit: BoxFit.contain,
            //                             ),
            //                             Expanded(
            //                               child: Padding(
            //                                 padding: const EdgeInsets.symmetric(
            //                                     horizontal: 12.0),
            //                                 child: Column(
            //                                   crossAxisAlignment:
            //                                       CrossAxisAlignment.start,
            //                                   children: [
            //                                     Text(
            //                                       ingredientsProvider
            //                                           .freshList![index]
            //                                           .mealType!,
            //                                       style: TextStyle(
            //                                           fontFamily:
            //                                               'Hellix-MediumItalic',
            //                                           fontSize: 13.0,
            //                                           color: Colors.cyan[700],
            //                                           fontWeight:
            //                                               FontWeight.normal),
            //                                     ),
            //                                     const SizedBox(
            //                                       height: 6.0,
            //                                     ),
            //                                     Row(
            //                                       children: [
            //                                         Flexible(
            //                                           child: Text(
            //                                             ingredientsProvider
            //                                                 .freshList![index]
            //                                                 .title!,
            //                                             // overflow: TextOverflow.ellipsis,
            //                                             style: const TextStyle(
            //                                                 fontSize: 16.0,
            //                                                 fontFamily:
            //                                                     "LibreBaskerville"),
            //                                           ),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                     const SizedBox(
            //                                       height: 6.0,
            //                                     ),
            //                                     Row(
            //                                       children: [
            //                                         Row(
            //                                           children: [
            //                                             // List.generate(5, (index) =>   Icon(Icons.star,color: Colors.orange[800],),),
            //                                             Icon(
            //                                               Icons.star,
            //                                               color: Colors
            //                                                   .orange[800],
            //                                               size: 16,
            //                                             ),
            //                                             Icon(
            //                                               Icons.star,
            //                                               color: Colors
            //                                                   .orange[800],
            //                                               size: 16,
            //                                             ),
            //                                             Icon(
            //                                               Icons.star,
            //                                               color: Colors
            //                                                   .orange[800],
            //                                               size: 16,
            //                                             ),
            //                                             Icon(
            //                                               Icons.star,
            //                                               color: Colors
            //                                                   .orange[800],
            //                                               size: 16,
            //                                             ),
            //                                             const SizedBox(
            //                                               width: 6.0,
            //                                             ),
            //                                             Text(
            //                                               "${ingredientsProvider.freshList![index].mealType!}  Calories",
            //                                               style: TextStyle(
            //                                                   color: Colors
            //                                                       .orange[900],
            //                                                   fontSize: 14.0,
            //                                                   fontWeight:
            //                                                       FontWeight
            //                                                           .w400),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ],
            //                                     ),
            //                                     const SizedBox(
            //                                       height: 6.0,
            //                                     ),
            //                                     Row(
            //                                       children: [
            //                                         Icon(
            //                                           Icons.access_time,
            //                                           color: Colors.grey[400],
            //                                           size: 19.0,
            //                                         ),
            //                                         const SizedBox(
            //                                           width: 5.0,
            //                                         ),
            //                                         Text(
            //                                           "${ingredientsProvider.freshList![index].time.toString()} mins",
            //                                           style: TextStyle(
            //                                               fontSize: 13.0,
            //                                               color:
            //                                                   Colors.grey[500]),
            //                                         ),
            //                                         const SizedBox(
            //                                           width: 16.0,
            //                                         ),
            //                                         Row(
            //                                           children: [
            //                                             Icon(
            //                                               Icons
            //                                                   .room_service_outlined,
            //                                               color:
            //                                                   Colors.grey[400],
            //                                               size: 19.0,
            //                                             ),
            //                                             const SizedBox(
            //                                               width: 5.0,
            //                                             ),
            //                                             Text(
            //                                               "${ingredientsProvider.freshList![index].mealType!} Serving",
            //                                               style: TextStyle(
            //                                                   fontSize: 13.0,
            //                                                   color: Colors
            //                                                       .grey[500]),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ),
            //                             Align(
            //                               alignment: Alignment.topCenter,
            //                               child: Container(
            //                                 height: 96.0,
            //                                 width: 28.0,
            //                                 child: IconButton(
            //                                   onPressed: () {
            //                                     // ingredientsProvider
            //                                     //     .favouriteList![index]
            //                                     //     .users_ids
            //                                     //     ?.contains(FirebaseAuth
            //                                     //     .instance.currentUser?.uid);
            //
            //                                     setState(() {
            //                                       ingredientsProvider
            //                                           .addIngredientToUser(
            //                                               ingredientsProvider
            //                                                   .freshList![index]
            //                                                   .docId!,
            //                                               value);
            //                                     });
            //                                   },
            //                                   icon: value
            //                                       ? const Icon(
            //                                           Icons.favorite_border)
            //                                       : const Icon(
            //                                           Icons.favorite,
            //                                         ),
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       );
            //                     }, //return to container two
            //                   )),
          ],
        ),
      ),
    );
  }
}
