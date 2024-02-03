import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasty_recipe_app/firebase_options.dart';
import 'package:tasty_recipe_app/pages/splash_screen_page.dart';
import 'package:tasty_recipe_app/provider/ads_provider.dart';
import 'package:tasty_recipe_app/provider/app_auth.provider.dart';
import 'package:tasty_recipe_app/provider/recipes.provider.dart';

void main() async {
  //shared preference by get-it
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var preference = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(preference);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('=======Error in init prefernces ${e}====');
  }

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AppAuthProvider()),
      ChangeNotifierProvider(create: (_) => AdsProvider()),
      ChangeNotifierProvider(create: (_) => FreshRecipesProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlayKit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreenPage(),
      ),
    );
  }
}

//SharedPreferences taraka
//   try {
//     PrefrencesService.prefs = await SharedPreferences.getInstance();
//     if (PrefrencesService.prefs != null) {
//       print('======= prefrences init successfully====');
//     }
//   } catch (e) {
//     print('=======Error in init prefernces ${e}====');
//   }
