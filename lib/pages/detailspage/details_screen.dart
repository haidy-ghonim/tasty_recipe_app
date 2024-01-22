//inside taste food page
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  // final String name;
  const DetailsScreen(
    freshList, {
    super.key,
    // required this.name
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultIconLightColor,
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
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
      body: Container(
        margin: const EdgeInsets.only(top: 64.0, left: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 28.0),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.star,
                        color: kDefaultIconLightColor,
                      ))),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: const Text(
                "name",
                // widget.name,
                style:
                    TextStyle(fontSize: 25.0, fontFamily: "LibreBaskerville"),
              ),
            ),
            const SizedBox(height: 24.0),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "\$",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "LibreBaskerville",
                        color: Colors.orange,
                      ),
                  ),

                  TextSpan(text: " 250.25",
                    style: TextStyle(
                      fontSize: 26.0,
                      fontFamily: "LibreBaskerville",
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
             //33
            const SizedBox(height: 24.0),
            Image.asset("images/frensh toast.png"),




          ],
        ),
      ),
    );
  }
}
