import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/models/ad.model.dart';
import 'package:tasty_recipe_app/pages/filter_page.dart';
import 'package:tasty_recipe_app/provider/ads_provider.dart';

//todo main screen home  first
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var sliderIndex = 0;

  List freshList = [
    {
      "image": "images/frensh toast.png",
      "name": "Fresh Toast with Berries asdasasdas "
    },
    {
      "image": "images/Cinnamon Toaast.png",
      "name": "Brow Sugar Cinnamon Toast"
    },
    {"image": "images/GlazedSalmon.png", "name": "Asian Glazed Chicken Things"},
  ];

  List recommendedList = [
    {"image": "images/Muffins.png", "name": "Blueberry Muffins"},
    {"image": "images/GlazedSalmon.png", "name": "Glazed Salmon"},
    {"image": "images/chicken.png", "name": "Asian Glazed Chicken Things"},
    {"image": "images/Muffins.png", "name": "Blueberry Muffins"},
    {"image": "images/GlazedSalmon.png", "name": "Glazed Salmon"},
    {"image": "images/chicken.png", "name": "Asian Glazed Chicken Things"},
  ];

  List<Ad> adsList = [];

  // void getAda() async {
  //   var adsData = await rootBundle.loadString('assets/data/sample.json');
  //   var dataDecoded =
  //       List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
  //   adsList = dataDecoded.map((e) => Ad.fromJson(e)).toList();
  //   setState(() {});
  // }

  @override
  void initState() {
    // getAda();
    super.initState();
  }

  final int _currentPosition = 0;

  String getPrettyCurrPosition() {
    return (_currentPosition + 1.0).toStringAsPrecision(3);
  }

  final decorator = DotsDecorator(
    activeColor: Colors.red,
    size: const Size.square(15.0),
    activeSize: const Size.square(35.0),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
  );

//carousel slider image

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultIconLightColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            if (ZoomDrawer.of(context)!.isOpen()) {
              ZoomDrawer.of(context)!.close();
            } else {
              ZoomDrawer.of(context)!.open();
            }
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
                    "Bonjour, Emma",
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            // Padding(padding:EdgeInsets.only(left: 25,top: 0,right: 0,bottom: 0) ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, right: 0, bottom: 0),
              child: Text(
                "What Would You Like To  Cook Today?",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "LibreBaskerville",
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
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

            // todo CarouselSlider
            Consumer<AdsProvider>(builder: (context, value, child) {
              return Container(
                child: Provider.of<AdsProvider>(context).ads.isEmpty
                    ? const CircularProgressIndicator()
                    :  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.topLeft,
                            children: [
                                // CarouselSlider(
                                //        carouselController: _controller,
                                //      options: CarouselOptions(
                                //         height: 200.0    ,
                                //
                                //
                                //      )  ,
                                //
                                //
                                //
                                //
                                //   items: ,
                                //    )

                            ],
                          ),
                        ],
                      ),
              );
            }),
          ], //childern
        ),
      ),
    );
  }
}
