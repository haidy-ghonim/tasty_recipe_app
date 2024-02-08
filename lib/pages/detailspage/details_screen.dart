//inside taste food page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/models/recipe.model.dart';
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
      appBar: AppBar(),
      body: ListTile(
        title: Text(widget.recipe.title ?? ''),
        trailing: InkWell(
            onTap: () {
              Provider.of<FreshRecipesProvider>(context, listen: false)
                  .addRecipeToUserFavourite(widget.recipe.docId!, isInList);
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

      // body : listveiw
      //scro //child text row heart on tap
      //           : Container(
      //               margin: const EdgeInsets.only(top: 64.0, left: 28.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Align(
      //                     alignment: Alignment.centerRight,
      //                     child: Container(
      //                         margin:
      //                             const EdgeInsets.symmetric(horizontal: 28.0),
      //                         decoration: BoxDecoration(
      //                             color: Colors.orange,
      //                             borderRadius: BorderRadius.circular(8.0)),
      //                         child: IconButton(
      //                             onPressed: () {},
      //                             icon: Icon(
      //                               Icons.star,
      //                               color: kDefaultIconLightColor,
      //                             ))),
      //                   ),
      //                   Container(
      //                     width: MediaQuery.of(context).size.width / 1.5,
      //                     child: const Text(
      //                       'namme',
      //                       // freshRecipesProvider
      //                       //     .freshList![
      //                       // index]
      //                       //     .title!,
      //                       style: TextStyle(
      //                           fontSize: 25.0, fontFamily: "LibreBaskerville"),
      //                     ),
      //                   ),
      //                   const SizedBox(height: 24.0),
      //                   const Text.rich(
      //                     TextSpan(
      //                       children: [
      //                         TextSpan(
      //                           text: "\$",
      //                           style: TextStyle(
      //                             fontSize: 16.0,
      //                             fontFamily: "LibreBaskerville",
      //                             color: Colors.orange,
      //                           ),
      //                         ),
      //                         TextSpan(
      //                           text: " 250.25",
      //                           style: TextStyle(
      //                             fontSize: 26.0,
      //                             fontFamily: "LibreBaskerville",
      //                             color: Colors.orange,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   //33
      //                   const SizedBox(height: 24.0),
      //                   SingleChildScrollView(
      //                     scrollDirection: Axis.horizontal,
      //                     physics: const NeverScrollableScrollPhysics(),
      //                     child: Row(
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: [
      //                         Container(
      //                           width: MediaQuery.of(context).size.width / 3.6,
      //                           child: const Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Text(
      //                                 'Calories',
      //                                 style: TextStyle(
      //                                   fontSize: 16.0,
      //                                   color: Colors.grey,
      //                                   fontFamily: "LibreBaskerville",
      //                                 ),
      //                               ),
      //                               SizedBox(height: 4.0),
      //                               Text(
      //                                 '120 Calories',
      //                                 style: TextStyle(
      //                                     fontSize: 20.0,
      //                                     fontFamily: "Hellix-bold"),
      //                               ),
      //                               SizedBox(height: 36.0),
      //                               Text(
      //                                 'Time',
      //                                 style: TextStyle(
      //                                   fontSize: 16.0,
      //                                   color: Colors.grey,
      //                                   fontFamily: "LibreBaskerville",
      //                                 ),
      //                               ),
      //                               SizedBox(height: 4.0),
      //                               Text(
      //                                 '10 Time',
      //                                 style: TextStyle(
      //                                     fontSize: 20.0,
      //                                     fontFamily: "Hellix-bold"),
      //                               ),
      //                               SizedBox(height: 36.0),
      //                               Text(
      //                                 'Total Service',
      //                                 style: TextStyle(
      //                                   fontSize: 16.0,
      //                                   color: Colors.grey,
      //                                   fontFamily: "LibreBaskerville",
      //                                 ),
      //                               ),
      //                               SizedBox(height: 4.0),
      //                               Text(
      //                                 '1 Serving',
      //                                 style: TextStyle(
      //                                     fontSize: 20.0,
      //                                     fontFamily: "Hellix-bold"),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                         Image.asset(
      //                           "images/frensh toast.png",
      //                           height: 250,
      //                           fit: BoxFit.contain,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   const SizedBox(height: 24.0),
      //                   const Text(
      //                     "Description",
      //                     style: TextStyle(
      //                         fontSize: 20.0, fontFamily: "Hellix-bold"),
      //                   ),
      //                   const SizedBox(height: 8.0),
      //                   const Padding(
      //                     padding: EdgeInsets.only(right: 28.0,bottom: 28.0),
      //                     child: Text(
      //                       "Description jkklkldskdjlsjalj kjdjsokowkdlwk;lk jokokokjjkoj",
      //                       style: TextStyle(
      //                           fontSize: 16.0, fontFamily: "Hellix-bold"),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      // ),
    );
  }
}
