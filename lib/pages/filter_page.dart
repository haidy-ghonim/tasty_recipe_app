import 'package:flutter/material.dart';
//todo  filter

class FilterScreenPage extends StatefulWidget {
  const FilterScreenPage({super.key});

  @override
  State<FilterScreenPage> createState() => _FilterScreenPageState();
}

class _FilterScreenPageState extends State<FilterScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.symmetric(horizontal: 12),
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

              // =>
              //
              //     Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) =>
              //         const FilterScreenPage())
              //
              //     ),
              child: Text(
                "Reset All",
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: "LibreBaskerville",
                  color: Colors.orange[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // GestureDetector(
            //   onTap: () {},
            //   child:
            // ),
          ],
        ),
      ),
    );
  }
}
