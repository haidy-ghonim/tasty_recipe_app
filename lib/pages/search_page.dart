// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:tasty_recipe_app/pages/home_screen_pages/home_first_screen.dart';
//
// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});
//
//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   List searchList = [];
//
//   void searchFromFirebase(String search) async {
//     final result = await FirebaseFirestore.instance
//         .collection('recipes')
//         .where(
//           "title",
//           arrayContains: search,
//         )
//         .get();
//
//     setState(() {
//       searchList = result.docs.map((e) => e.data()).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (_) => const HomeFirstScreen()));
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Lottie.network(
//                 'https://lottie.host/f15ed9f6-df3a-4fe5-854d-c61951d77a28/rMnQwRRxX0.json'
//                 // 'https://lottie.host/2adf013a-659e-4c6a-96f3-4a5fec2c27e6/g1EC3MyqEY.json'
//                 ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//         ],
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: TextField(
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Search about Product",
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.grey,
//                   size: 18.0,
//                 ),
//               ),
//               onChanged: (value) {
//                 searchFromFirebase(value);
//               },
//             ),
//           ),
//           Expanded(
//               child: ListView.builder(
//                   itemCount: seeAll.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(seeAll[index]['title']),
//                       subtitle: Text(seeAll[index]['mealType']),
//                     );
//                   }))
//         ],
//       ),
//     );
//   }
// }
