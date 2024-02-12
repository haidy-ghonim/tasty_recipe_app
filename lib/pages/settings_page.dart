import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tasty_recipe_app/pages/home_screen_pages/home_first_screen.dart';
import 'package:tasty_recipe_app/pages/portoflio_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultIconLightColor,
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

      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 12.0,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 5, right: 0, bottom: 0),
            child: Text(
              "Settings",
              style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: "LibreBaskerville",
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15)),
              child:  ListTile(
                title: const Text('Language',
                  style: TextStyle(fontSize: 18),
                ),
                leading: const Icon(Icons.language),
                trailing: Text(
                  'English',
                  style: TextStyle(color: Colors.orange[600], fontSize: 15),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20), // Add some space before the button
          Container(
            width: 400,
              child: Lottie.network
          ('https://lottie.host/b13d8a4e-7b1c-463c-9a17-a07027cde157/0bPihk8cA4.json')),
          const SizedBox(height: 60), // Add some space before the button
          Center(
            child: Container(
              child: CupertinoButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PortfolioPage(),
                      ));
                },
                padding: const EdgeInsets.all(12.0),
                borderRadius: BorderRadius.circular(12.0),
                color: CupertinoColors.activeOrange,
                child: const Text('Create Profile'),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
