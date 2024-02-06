import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/models/recipe.model.dart';
import 'package:tasty_recipe_app/pages/detailspage/details_screen.dart';
import 'package:tasty_recipe_app/pages/filter_page.dart';
import 'package:tasty_recipe_app/pages/see.all_recipes_page.dart';
import 'package:tasty_recipe_app/provider/ads_provider.dart';
import 'package:tasty_recipe_app/provider/recipes.provider.dart';

//todo main screen home  first
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await Provider.of<AdsProvider>(context, listen: false).getAds();
    await Provider.of<FreshRecipesProvider>(context, listen: false)
        .getFreshRecipes();
    await Provider.of<FreshRecipesProvider>(context, listen: false)
        .getRecommended();
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

  RecipeModel? recipemodel;

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
                        onTap: () {}, //todo search same thing make page
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

                  //todo see all
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AllRecipesPage())),

                    // print("see all fresh recipes"),
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
              builder: (context, freshRecipesProvider, _) =>
                  freshRecipesProvider.freshList == null
                      ? const CircularProgressIndicator()
                      : (freshRecipesProvider.freshList?.isEmpty ?? false)
                          ? const Text('NO DATA FOUND')
                          : Container(
                              height: 340,
                              padding: const EdgeInsets.only(
                                  left: 10, top: 0, right: 10, bottom: 0),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: freshRecipesProvider
                                    .freshList!.length, //todo fresh list besa
                                itemBuilder: (context, index) {
                                  //todo el page el feha back plate
                                  return GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                            freshRecipesProvider
                                                .freshList![index].image!),
                                      ),
                                    ),
                                    child: Card(
                                      color: Colors.grey[100],
                                      // elevation: 2,
                                      child: Container(
                                        height: 200,
                                        width: 210,
                                        // margin: const EdgeInsets.only(
                                        //     right: 10.0, left: 10.0),
                                        decoration: BoxDecoration(
                                          // color: Colors.grey[200],
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
                                                    freshRecipesProvider
                                                        .freshList![index]
                                                        .image!,
                                                    fit: BoxFit.contain,
                                                    width: 210,
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
                                                        freshRecipesProvider.addRecipeToUserFavourite(
                                                            freshRecipesProvider
                                                                .freshList![
                                                                    index]
                                                                .docId!,
                                                            !(freshRecipesProvider
                                                                    .freshList![
                                                                        index]
                                                                    .users_ids
                                                                    ?.contains(FirebaseAuth
                                                                        .instance
                                                                        .currentUser
                                                                        ?.uid) ??
                                                                false));
                                                      },
                                                      child: (freshRecipesProvider
                                                                  .freshList![
                                                                      index]
                                                                  .users_ids
                                                                  ?.contains(FirebaseAuth
                                                                      .instance
                                                                      .currentUser
                                                                      ?.uid) ??
                                                              false
                                                          ? const Icon(
                                                              Icons
                                                                  .favorite_border_rounded,
                                                              size: 30,
                                                              color:
                                                                  Colors.grey,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .favorite_border_rounded,
                                                              size: 30,
                                                              color:
                                                                  Colors.grey,
                                                            )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              //top: 150,
                                              // left: 20,
                                              child: Padding(
                                                //   padding: const EdgeInsets.symmetric(
                                                //       horizontal: 20),
                                                padding: const EdgeInsets.only(
                                                    left: 14,
                                                    top: 20,
                                                    right: 10,
                                                    bottom: 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      freshRecipesProvider
                                                          .freshList![index]
                                                          .mealType!,
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
                                                      height: 16.0,
                                                    ),
                                                    Container(
                                                      width: 300,
                                                      child: Row(
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              freshRecipesProvider
                                                                  .freshList![
                                                                      index]
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
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      updateOnDrag: true,
                                                      unratedColor: Colors.grey,
                                                      itemCount:
                                                          5, //todo how to give rate
                                                      itemSize: 15,
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                              Icons.star,
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
                                                      "${freshRecipesProvider.freshList![index].calories!}  Calories",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .orange[900],
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
                                                          color:
                                                              Colors.grey[400],
                                                          size: 19.0,
                                                        ),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                          "${freshRecipesProvider.freshList![index].totalTime.toString()} mins",
                                                          style: TextStyle(
                                                              fontSize: 13.0,
                                                              color: Colors
                                                                  .grey[500]),
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
                                                                  .grey[400],
                                                              size: 19.0,
                                                            ),
                                                            const SizedBox(
                                                              width: 3.0,
                                                            ),
                                                            Text(
                                                              "${freshRecipesProvider.freshList![index].serving.toString()} Serving",
                                                              style: TextStyle(
                                                                fontSize: 12.0,
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

                  //todo see all
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AllRecipesPage())),
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
            //********************  todo Recommended list complete
            Consumer<FreshRecipesProvider>(
              builder: (context, freshRecipesProvider, _) =>
                  freshRecipesProvider.recommendedList == null
                      ? const CircularProgressIndicator()
                      : (freshRecipesProvider.recommendedList?.isEmpty ?? false)
                          ? const Text('NO DATA FOUND')
                          : Container(
                              // height: 350,
                              padding: const EdgeInsets.only(
                                  left: 5, top: 0, right: 5, bottom: 0),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: freshRecipesProvider
                                    .recommendedList!.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  //todo el page el feha back plate
                                  return GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(
                                                      freshRecipesProvider
                                                          .recommendedList![
                                                              index]
                                                          .title))),
                                      child: Card(
                                        color: Colors.grey[100],
                                        child: Container(
                                          height: 150,
                                          width: 80,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 5, left: 10),
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
                                                  freshRecipesProvider
                                                      .recommendedList![index]
                                                      .image!,
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
                                                            freshRecipesProvider
                                                                .recommendedList![
                                                                    index]
                                                                .mealType!,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Hellix-MediumItalic',
                                                                fontSize: 13.0,
                                                                color: Colors
                                                                    .cyan[700],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                          const Spacer(),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    freshRecipesProvider.addRecipeToUserFavourite(
                                                                        freshRecipesProvider
                                                                            .recommendedList![
                                                                                index]
                                                                            .docId!,
                                                                        !(freshRecipesProvider.recommendedList![index].users_ids?.contains(FirebaseAuth.instance.currentUser?.uid) ??
                                                                            false));
                                                                  },
                                                                  child: (freshRecipesProvider
                                                                              .recommendedList![index]
                                                                              .users_ids
                                                                              ?.contains(FirebaseAuth.instance.currentUser?.uid) ??
                                                                          false
                                                                      ? Icon(
                                                                          Icons
                                                                              .favorite_rounded,
                                                                          size:
                                                                              30,
                                                                          color:
                                                                              Colors.orange[900],
                                                                        )
                                                                      : const Icon(
                                                                          Icons
                                                                              .favorite_border_rounded,
                                                                          size:
                                                                              30,
                                                                          color:
                                                                              Colors.grey,
                                                                        ))),
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
                                                              freshRecipesProvider
                                                                  .recommendedList![
                                                                      index]
                                                                  .title!,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                                              RatingBar.builder(
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
                                                                    Colors.grey,
                                                                itemCount:
                                                                    5, //todo how to give rate
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
                                                                "${freshRecipesProvider.recommendedList![index].calories!}  Calories",
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
                                                            "${freshRecipesProvider.recommendedList![index].totalTime.toString()} mins",
                                                            style: TextStyle(
                                                                fontSize: 13.0,
                                                                color: Colors
                                                                    .grey[500]),
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
                                                                    .grey[400],
                                                                size: 19.0,
                                                              ),
                                                              const SizedBox(
                                                                width: 5.0,
                                                              ),
                                                              Text(
                                                                "${freshRecipesProvider.recommendedList![index].serving.toString()} Serving",
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
                                      )
                                      // )
                                      );
                                }, //return to container two
                              ),
                            ),
            ),
          ], //children
        ),
      ),
    );
  }
}
