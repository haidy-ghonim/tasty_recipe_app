import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/pages/filter_page.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/main_screen_page.dart';
import 'package:tasty_recipe_app/provider/ingredient_provider.dart';

class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List ingredientsList = [];

  @override
  void initState() {
    Provider.of<IngredientsProvider>(context, listen: false).getIngredients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.cyanAccent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const FilterScreenPage())),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Consumer<IngredientsProvider>(
          builder: (ctx, ingredientProvider, _) =>
              ingredientProvider.ingredientsList == null
                  ? const CircularProgressIndicator()
                  : (ingredientProvider.ingredientsList?.isEmpty ?? false)
                      ? const Text('No Data Found')
                      : ListView.builder(
                          itemCount: ingredientProvider.ingredientsList!.length,
                          itemBuilder: (context, index) => Container(
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                        width: 70,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                ingredientProvider
                                                        .ingredientsList![index]
                                                        .imageUrl ??
                                                    'image'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      title: Text(ingredientProvider
                                              .ingredientsList![index].name ??
                                          'No Name'),
                                      trailing: Checkbox(
                                          value: ingredientProvider
                                              .ingredientsList![index].users_ids
                                              ?.contains(FirebaseAuth
                                                  .instance.currentUser?.uid),
                                          onChanged: (value) {
                                            ingredientProvider
                                                .addIngredientToUser(
                                                    ingredientProvider
                                                        .ingredientsList![index]
                                                        .docId!,
                                                    value ?? false);
                                          }),
                                    ),
                                  ],
                                ),
                              ))),
    );
  }
}
