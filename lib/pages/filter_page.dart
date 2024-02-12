import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/home_first_screen.dart';
import 'package:tasty_recipe_app/pages/result_filter_page.dart';
import 'package:tasty_recipe_app/provider/recipes.provider.dart';
//todo  filter

class FilterScreenPage extends StatefulWidget {
  const FilterScreenPage({super.key});

  @override
  State<FilterScreenPage> createState() => _FilterScreenPageState();
}

class _FilterScreenPageState extends State<FilterScreenPage> {
  var chosseUserValue = {}; //empty map
  double valueServing = 0;
  double valuePrepareTime = 0;
  double valueCalories = 0;
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
                'https://lottie.host/f15ed9f6-df3a-4fe5-854d-c61951d77a28/rMnQwRRxX0.json'
                // 'https://lottie.host/2adf013a-659e-4c6a-96f3-4a5fec2c27e6/g1EC3MyqEY.json'
                ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
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
                          "Reset",
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
                Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 10),
                      child: Wrap(spacing: 10, children: [
                        InkWell(
                          onTap: () {
                            chosseUserValue['mealType'] = "BreakFast";
                            setState(() {});
                          },
                          child: Chip(
                            label: const Text('BreakFast'),
                            avatar: Icon(
                              Icons.free_breakfast,
                              color: Colors.lime[400],
                            ),
                            backgroundColor:
                                chosseUserValue['mealType'] == "BreakFast"
                                    ? Colors.orange[300]
                                    : Colors.grey[100],
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            chosseUserValue['mealType'] = "Brunch";
                            setState(() {});
                          },
                          child: Chip(
                            label: const Text('Brunch'),
                            avatar: const Icon(
                              Icons.brunch_dining,
                              color: Colors.blueGrey,
                            ),
                            backgroundColor:
                                chosseUserValue['mealType'] == "Brunch"
                                    ? Colors.orange[300]
                                    : Colors.grey[100],
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            chosseUserValue['mealType'] = "Lunch";
                            setState(() {});
                          },
                          child: Chip(
                            label: const Text('Lunch'),
                            avatar: Icon(
                              Icons.lunch_dining,
                              color: Colors.yellow[600],
                            ),
                            backgroundColor:
                                chosseUserValue['mealType'] == "Lunch"
                                    ? Colors.orange[300]
                                    : Colors.grey[100],
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            chosseUserValue['mealType'] = "Dinner";
                            setState(() {});
                          },
                          child: Chip(
                            label: const Text('Dinner'),
                            avatar: const Icon(
                              Icons.dinner_dining,
                              color: Colors.red,
                            ),
                            backgroundColor:
                                chosseUserValue['mealType'] == "Dinner"
                                    ? Colors.orange[300]
                                    : Colors.grey[100],
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                          ),
                        )
                      ]),
                    ),
                  ],
                )),

                //todo serving
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Serving",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "LibreBaskerville",
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 10),
                      child: Wrap(spacing: 10, children: [
                        Slider(
                            value: valueServing,
                            min: 0,
                            max: 10,
                            divisions: 5,
                            activeColor: Colors.orange[500],
                            inactiveColor: Colors.orange.shade100,
                            label: valueServing.round().toString(),
                            onChanged: (value) {
                              setState(() {
                                valueServing = value;
                              });
                            }),
                      ]),
                    ),
                  ],
                )),

                //todo time
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Preparation Time",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "LibreBaskerville",
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 10),
                      child: Wrap(spacing: 10, children: [
                        Slider(
                            value: valuePrepareTime,
                            min: 0,
                            max: 160,
                            divisions: 20,
                            activeColor: Colors.orange[500],
                            inactiveColor: Colors.orange.shade100,
                            label: valuePrepareTime.round().toString(),
                            onChanged: (value) {
                              setState(() {
                                valuePrepareTime = value;
                              });
                            }),
                      ]),
                    ),
                  ],
                )),
                //todo calories
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Calories",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "LibreBaskerville",
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 10),
                        child: Wrap(
                          spacing: 10,
                          children: [
                            Slider(
                                value: valueCalories,
                                min: 0,
                                max: 400,
                                divisions: 20,
                                activeColor: Colors.orange[500],
                                inactiveColor: Colors.orange.shade100,
                                label: valueCalories.round().toString(),
                                onChanged: (value) {
                                  setState(() {
                                    valueCalories = value;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Provider.of<FreshRecipesProvider>(context, listen: false)
              .getFilteredResult();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ResultFilterPage(
                        resultFilter: [],
                      )));
        },
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
              "Apply",
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
