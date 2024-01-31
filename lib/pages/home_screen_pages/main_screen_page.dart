import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/models/ad.model.dart';
import 'package:tasty_recipe_app/pages/detailspage/details_screen.dart';
import 'package:tasty_recipe_app/pages/filter_page.dart';
import 'package:tasty_recipe_app/provider/ads_provider.dart';
import 'package:tasty_recipe_app/provider/fresh_recipes.provider.dart';

//todo main screen home  first
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool favorite = true;

  void toggleFavorite() {
    favorite = !favorite;
    setState(() {});
  }

  List<Ad> freshList = [
    // {
    //   "image": "images/frensh toast.png",
    //   "name": "Fresh Toast with Berries asdasasdas "
    // },
    // {
    //   "image": "images/Cinnamon Toaast.png",
    //   "name": "Brow Sugar Cinnamon Toast"
    // },
    // {"image": "images/GlazedSalmon.png", "name": "Asian Glazed Chicken Things"},
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
    init();
    super.initState();
  }

  void init() async {
    await Provider.of<AdsProvider>(context, listen: false).getAds();
    await Provider.of<FreshRecipesProvider>(context, listen: false)
        .getTodayRecipes();
    // await Provider.of<IngredientsProvider>(context,listen: false).getIngredient();
  }

  @override
  void dispose() {
    Provider.of<AdsProvider>(context, listen: false).disposedCarousel();
    super.dispose();
  }

  final int _currentPosition = 0;

  String getPrettyCurrPosition() {
    return (_currentPosition + 1.0).toStringAsPrecision(3);
  }

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
                        onTap: () {}, //search same thing make page
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

            // todo CarouselSlider  value /adProvider
            Consumer<AdsProvider>(
                builder: (context, adProvider, _) => adProvider.adsList == null
                    ? const CircularProgressIndicator()
                    : (adProvider.adsList?.isEmpty ?? false)
                        ? const Text('NO DATA FOUND')
                        : Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    CarouselSlider(
                                      carouselController:
                                          adProvider.carouselController,
                                      options: CarouselOptions(
                                        height: 200.0,
                                        viewportFraction: .75,
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.height,
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        aspectRatio: 0.5,
                                        initialPage: 0,
                                        reverse: false,
                                        enableInfiniteScroll: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 2000),
                                        pauseAutoPlayOnTouch: true,
                                        onPageChanged: (index, _) =>
                                            adProvider.onPageChanged(index),
                                        enlargeFactor: .3,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                      // items: state.ads.map((ad)
                                      items: adProvider.adsList!.map((ad) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Stack(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              ad.image!)),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Text(
                                                      ad.title!,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black38,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  await adProvider
                                                      .carouselController
                                                      ?.previousPage();
                                                },
                                                icon: const Icon(
                                                    Icons.arrow_back_ios)),
                                            IconButton(
                                                onPressed: () async {
                                                  await adProvider
                                                      .carouselController!
                                                      .nextPage();
                                                },
                                                icon: const Icon(
                                                    Icons.arrow_forward_ios)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      DotsIndicator(
                                        dotsCount: adProvider.adsList!.length,
                                        position: adProvider.sliderIndex,
                                        onTap: (position) =>
                                            adProvider.onDotTappedRow(position),
                                        decorator: DotsDecorator(
                                          activeColor: Colors.orangeAccent,
                                          size: const Size.square(9.0),
                                          activeSize: const Size(18.0, 9.0),
                                          activeShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                        ),
                                      ),
                                    ]),
                              ],
                            ),
                          )),

            const SizedBox(
              height: 40,
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 20, top: 0, right: 15, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Fresh Recipes",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "LibreBaskerville",
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print("see all fresh recipes"),
                    child: Text(
                      "See All",
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

            //************** //todo today
            const SizedBox(
              height: 16.0,
            ),

            // moram3at el feha el kalam
            Consumer<FreshRecipesProvider>(
              builder: (context, freshRecipesProvide, _) => freshRecipesProvide
                          .freshList ==
                      null
                  ? const CircularProgressIndicator()
                  : (freshRecipesProvide.freshList?.isEmpty ?? false)
                      ? const Text('NO DATA FOUND')
                      : Container(
                          height: 370,
                          padding: const EdgeInsets.only(
                              left: 10, top: 0, right: 10, bottom: 0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: freshRecipesProvide
                                .freshList!.length, //todo fresh list besa
                            itemBuilder: (context, index) {
                              //todo el page el feha back plate
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                        freshRecipesProvide
                                            .freshList![index].image!),
                                  ),
                                ),
                                child: Card(
                                  color: Colors.grey[100],
                                  // elevation: 2,
                                  child: Container(
                                    height: 300,
                                    width: 210,
                                    margin: const EdgeInsets.only(
                                        right: 10.0, left: 10.0),
                                    decoration: BoxDecoration(
                                      // color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
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
                                                  :  Icon(
                                                      Icons.favorite_rounded,
                                                      size: 30,
                                                      color: Colors.orange[900],
                                                    )),
                                          ),
                                        ),
                                        Positioned(
                                          top: 50,
                                          right: 4,
                                          height: 150,
                                          child: Image.network(
                                              freshRecipesProvide
                                                  .freshList![index].image!,
                                          fit: BoxFit.contain,
                                          ),

                                        ),
                                        Positioned(
                                          top: 210,
                                          // left: 20,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  freshRecipesProvide
                                                      .freshList![index]
                                                      .mealType!,
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
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  width: 300,
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          freshRecipesProvide
                                                              .freshList![index]
                                                              .title!,
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
                                                    // print(rating);
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 8.0,
                                                ),
                                                Text(
                                                  "${freshRecipesProvide.freshList![index].calories!}  Calories",
                                                  style: TextStyle(
                                                      color: Colors.orange[900],
                                                      fontSize: 14.0,
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
                                                      "${freshRecipesProvide.freshList![index].time.toString()} mins",
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color:
                                                              Colors.grey[500]),
                                                    ),
                                                    const SizedBox(
                                                      width: 16.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .room_service_outlined,
                                                          color:
                                                              Colors.grey[400],
                                                          size: 19.0,
                                                        ),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                          "${freshRecipesProvide.freshList![index].serving.toString()} Serving",
                                                          style: TextStyle(
                                                            fontSize: 13.0,
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
                              );
                            },
                          ),
                        ),
            ),
            const SizedBox(
              height: 16,
            ),
            //************
            // todo Recommended
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recommended",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "LibreBaskerville",
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print("see all Recommended"),
                    child: Text(
                      "See All",
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
              height: 16,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                //todo el page el feha back plate
                return
                    // GestureDetector(onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) =>
                    //           DetailsScreen(recommendedList[index]["name"]))),
                    //   child: Container(
                    //     height: 150.0,
                    //     width: MediaQuery.of(context).size.width,
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 12.0, vertical: 12.0),
                    //     margin: const EdgeInsets.only(bottom: 12.0),
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey[200],
                    //       borderRadius: BorderRadius.circular(20.0),
                    //     ),
                    //     child:

                    Container(
                  margin: const EdgeInsets.only(right: 20.0, top: 10, left: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        recommendedList[index]["image"],
                        height: 150.0,
                        width: 120.0,
                        fit: BoxFit.contain,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Breakfast",
                                        style: TextStyle(
                                            fontFamily: 'Hellix-MediumItalic',
                                            fontSize: 13.0,
                                            color: Colors.cyan[700],
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(
                                        width: 130,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            toggleFavorite();
                                          },
                                          child: (favorite
                                              ? const Icon(
                                                  Icons.favorite_border_rounded,
                                                  size: 30,
                                                  color: Colors.grey,
                                                )
                                              : const Icon(
                                                  Icons.favorite_rounded,
                                                  size: 30,
                                                  color: Colors.orange,
                                                ))),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      recommendedList[index]["name"],
                                      // overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: "LibreBaskerville"),
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
                                      RatingBar.builder(
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        updateOnDrag: true,
                                        unratedColor: Colors.grey,
                                        itemCount: 5, //todo how to give rate
                                        itemSize: 15,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.orange[900],
                                        ),
                                        onRatingUpdate: (rating) {
                                          // print(rating);
                                        },
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        "120 Calories",
                                        style: TextStyle(
                                            color: Colors.orange[900],
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
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
                                    color: Colors.grey[400],
                                    size: 19.0,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "10 mins",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.grey[500]),
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.room_service_outlined,
                                        color: Colors.grey[400],
                                        size: 19.0,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "1 Serving",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey[500]),
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
                );
              }, //return to container two
            ),

            //todo enum
            // FlutGroupedButtons<String>(
            //     // isRadio: true,
            //     data: MealType.values.map((e) => e.name).toList(),
            //     onChanged: (name) {
            //       print(name);
            //     }),
            //todo button el ta7ta
            // Center(
            //   child: ElevatedButton(
            //       onPressed: () async {
            //         OverlayLoadingProgress.start();
            //         FirebaseFirestore.instance.collection('ads').add({
            //           "title": "Chicken With Wheat Bread",
            //           "image":
            //               "https://images.pexels.com/photos/2741448/pexels-photo-2741448.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
            //         });
            //         OverlayLoadingProgress.stop();
            //
            //         // Provider.of<AppAuthProvider>(context,listen: false).signOut(context);
            //         // NavigationUtils.push(
            //         //     context: context, page: const PageViewPage());
            //       },
            //       child: const Text('Add')),
            // ),
          ], //children
        ),
      ),
    );
  }
}
