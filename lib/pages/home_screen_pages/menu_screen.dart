import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/provider/app_auth.provider.dart';

// class MenuItem {
//   String title;
//   IconData icon;
//   MenuItem(this.icon, this.title);
//
//   final List<MenuItem> options = [
//     MenuItem(Icons.payment, 'Payments'),
//     MenuItem(Icons.favorite, 'Discounts'),
//     MenuItem(Icons.notifications, 'Notification'),
//     MenuItem(Icons.format_list_bulleted, 'Orders'),
//     MenuItem(Icons.help, 'Help'),
//   ];
// }

// her name + icon
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // body: Column(),
      appBar: AppBar(
        // leadingWidth: 40,
        backgroundColor: Colors.red[100],
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/girl.jpg'),
            // radius: 20,
            // child: Image.asset('images/girl.jpg'),
          ),
        ),
        // centerTitle: true,
        title: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ListTile(
                    title: Text(
                      'Emman Holmes',
                      style: TextStyle(fontSize:7),
                    ),
                    subtitle: Text(
                      'View Profile',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
          ],
        ),
        // actions: [
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        // ],
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Wrap(
            children: [
              const ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: Text('Home'),
                // onTap: () => Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => const HomePage())),
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite_border,
                  // size: 30,
                ),
                title: const Text('Favourites'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.play_arrow_outlined,
                ),
                title: const Text('Recently Viewed'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                ),
                title: const Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.error_outline,
                ),
                title: const Text('About Us'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.help_outline,
                ),
                title: const Text('Help'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                ),
                title: const Text('Sign Out'),
                onTap: () {
                  Provider.of<AppAuthProvider>(context, listen: false)
                      .signOut(context);
                },
              ),
            ],
          ),
        ),
      ),
    );

//******************

    // body: Padding(
    //   padding: const EdgeInsets.all(10),
    //   child: Column(
    //     mainAxisAlignment:MainAxisAlignment.spaceAround ,
    //     children: [
    //       Text('JJJ'),
    //
    //     ],
    //   ),
    // ),

    //
    //   Scaffold(
    //
    //
    //   // appBar: AppBar(
    //   //   backgroundColor: Colors.red,
    //   //   elevation: 0,
    //   //   leading: CircleAvatar(
    //   //     backgroundImage:AssetImage('images/girl.jpg') ,
    //   //     radius: 40,
    //   //     // child: Image.asset('images/girl.jpg'),
    //   //   ),
    //   //   centerTitle: true,
    //
    //     // title: Column(
    //     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     //   children: [
    //     //     Container(
    //     //       margin: EdgeInsets.zero,
    //     //       child:  ListTile(
    //     //         title: Text(
    //     //           'Emman Holmes',
    //     //           style: TextStyle(fontSize: 10),
    //     //         ),
    //     //         subtitle: Text(
    //     //           'View Profile',
    //     //           style: TextStyle(fontSize: 10),
    //     //         ),
    //     //       ),
    //     //     ),
    //     //   ],
    //     // ),
    //     // actions: [
    //     //   IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
    //     // ],
    //
    //   // ),
    //
    //   body: SingleChildScrollView(
    //     child: Container(
    //       child:  Wrap(
    //         children: [
    //           ListTile(
    //             leading: const Icon(
    //               Icons.home,
    //             ),
    //             title: const Text('Home'),
    //             // onTap: () => Navigator.of(context).pushReplacement(
    //             //     MaterialPageRoute(builder: (context) => const HomePage())),
    //           ),
    //           ListTile(
    //             leading: const Icon(
    //               Icons.favorite_border,
    //               // size: 30,
    //             ),
    //             title: const Text('Favourites'),
    //             onTap: () {},
    //           ),
    //           ListTile(
    //             leading: const Icon(
    //               Icons.play_arrow_outlined,
    //             ),
    //             title: const Text('Recently Viewed'),
    //             onTap: () {},
    //           ),
    //           ListTile(
    //             leading: const Icon(
    //               Icons.settings,
    //             ),
    //             title: const Text('Settings'),
    //             onTap: () {},
    //           ),
    //           ListTile(
    //             leading: const Icon(
    //               Icons.error_outline,
    //             ),
    //             title: const Text('About Us'),
    //             onTap: () {},
    //           ),
    //           ListTile(
    //             leading: const Icon(
    //               Icons.help_outline,
    //             ),
    //             title: const Text('Help'),
    //             onTap: () {},
    //           ),
    //           ListTile(
    //             leading: const Icon(
    //               Icons.logout_outlined,
    //             ),
    //             title: const Text('Sign Out'),
    //             onTap: () {},
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
//****************
//Scaffold(
//         backgroundColor: Colors.orange,
//         appBar: AppBar(
//           backgroundColor: Colors.pink,
//         ),
//         body:Padding(padding:  const EdgeInsets.all(10),
//         child:
//            Column(
//             children: [
//               ListTile(iconColor: Colors.indigo,),
//             ],
//           ),
//         ),
//       ),

//   Widget buildHeader(BuildContext context) => Container(
//
//         color: Colors.cyan,
//         padding: EdgeInsets.only(
//           top: 24 + MediaQuery.of(context).padding.top,
//           bottom: 24,
//         ),
//         child:  const ListTile(
//           title: Text(
//             'Emman Holmes',
//             style: TextStyle(color: Colors.yellowAccent),
//           ),
//           subtitle: Text('View Profile'),
//           leading: Expanded(
//             child: CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('images/cook4.png'),
//             ),
//           ),
//         ),
//       );
//   Widget buildMenuItems(BuildContext context) => Container(
//         // padding:const EdgeInsets.symmetric(horizontal: 10) ,
//         margin: const EdgeInsets.fromLTRB(10, 80, 0, 0),
//         child: Wrap(
//           runSpacing: 16,
//           children: [
//             ListTile(
//               leading: const Icon(
//                 Icons.home,
//                 size: 30,
//               ),
//               title: const Text('Home'),
//               onTap: () => Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (context) => const HomePage())),
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.favorite_border,
//                 size: 30,
//               ),
//               title: const Text('Favourites'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.play_arrow_outlined,
//                 size: 30,
//               ),
//               title: const Text('Recently Viewed'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.settings,
//                 size: 30,
//               ),
//               title: const Text('Settings'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.error_outline,
//                 size: 30,
//               ),
//               title: const Text('About Us'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.help_outline,
//                 size: 30,
//               ),
//               title: const Text('Help'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.logout_outlined,
//                 size: 30,
//               ),
//               title: const Text('Sign Out'),
//               onTap: () {},
//             ),
//           ],
//         ),
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             buildHeader(context),
//             buildMenuItems(context),
//           ],
//         ),
//       ),
//     );
//   }
// }
