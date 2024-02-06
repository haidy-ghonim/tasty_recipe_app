import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_kit/overlay_kit.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.light_mode))
        ],
      ),
      body: Container(
        // padding: EdgeInsets.only(left: 16,top: 5,right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Lottie.network(
                      'https://lottie.host/87a8786a-259c-4ae3-a81b-ee5609aabd15/q1SeC2aMRm.json'),
                  // 'https://lottie.host/23c1e040-1e46-4d86-9ec3-914073497dd1/JsehSUdFAh.json',

                  // 'https://lottie.host/98529b00-5b65-4ba3-9414-434c83d3cd85/OTro1wMaOw.json'),
                  const SizedBox(
                    height: 11,
                  ),
                  Container(
                    child: Positioned(
                      top: 131,
                      child: Container(
                        width: 130,
                        height: 95,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.blue,
                          ),
                          shape: BoxShape.circle,
                          color: Colors.cyanAccent,
                          // image: DecorationImage(image: NetworkImage('')), Colors.cyanAccent,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(left: 50, bottom: 40),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.yellow),
                      //image upload
                      child: GestureDetector(
                        onTap: () async {
                          OverlayLoadingProgress.start();
                          var imageResult = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            withData: true,
                          );
                          var refrence = FirebaseStorage.instance
                              .ref('profile/${imageResult?.files.first.name}');
                          if (imageResult?.files.first.bytes != null) {
                            var uploadResult = await refrence.putData(
                                imageResult!.files.first.bytes!,
                                SettableMetadata(contentType: 'image/png'));

                         if (uploadResult.state ==TaskState.success){
                           print('image upload successfully ${await refrence.getDownloadURL()}');
                         }

                          }
                          OverlayLoadingProgress.stop();
                        },
                        child: const Icon(Icons.add),
                      ),
                      // IconButton(
                      //   onPressed: () {}, icon: const Icon(Icons.upgrade),
                      //
                      //   // color: Colors.orange,
                      // ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextField(
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.only(bottom: 1),
                    labelText: "Full Name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "",
                    hintStyle: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 1),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextField(
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "E-mail",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "",
                    hintStyle: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextField(
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Biographer",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 2.2,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 170,
                    // ),
                    // const Spacer(),
                    OutlinedButton(
                      //sign out me application
                      onPressed: () {},
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 2.2,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//   Scaffold(
//   body:
//   ListView(
//     padding: EdgeInsets.zero,
//     children: <Widget>[
//       Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.center,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 15),
//             //cover image
//             child: Container(
//               color: Colors.grey[400],
//               child: LottieBuilder.network(
//                 'https://lottie.host/af90f341-92b6-4f3b-aa0a-1ba07c3ba773/Hqnas8PWk7.json',
//                 // 'https://lottie.host/90c6e8be-7f9e-4baa-9120-f590c589e6f1/WlletAxaRg.json',
//                 width: double.infinity,
//                 height: 120,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//
//           // person image
//           Positioned(
//             top: 250,
//             child: CircleAvatar(
//               radius: 60,
//               backgroundColor: Colors.grey.shade800,
//               // child: Image.network(""),
//             ),
//           ),
//            Row(
//              children: [
//                SizedBox(
//                   height: 18,),
//                   Text('esse'),
//
//              ],
//            ),
//         ],
//       ),
//     ],
//   ),
// );

//Scaffold(
//       body: Column(
//         children: [
//           const Expanded(flex: 2, child: _TopPortion()),
//           Expanded(
//             flex: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Text(
//                     "Richie Lorie",
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6
//                         ?.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       FloatingActionButton.extended(
//                         onPressed: () {},
//                         heroTag: 'follow',
//                         elevation: 0,
//                         label: const Text("Follow"),
//                         icon: const Icon(Icons.person_add_alt_1),
//                       ),
//                       const SizedBox(width: 16.0),
//                       FloatingActionButton.extended(
//                         onPressed: () {},
//                         heroTag: 'mesage',
//                         elevation: 0,
//                         backgroundColor: Colors.red,
//                         label: const Text("Message"),
//                         icon: const Icon(Icons.message_rounded),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   const _ProfileInfoRow()
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // content
// Widget buildContent() => Column(
//   children: [
//     const SizedBox(
//       height: 18,
//     ),
//     const Text(
//       ' Haidy Ghonim',
//       style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//     ),
//     const SizedBox(
//       height: 8,
//     ),
//     const Text(
//       'Teacher Assistent & Developer',
//       style: TextStyle(fontSize: 18, height: 1.4),
//     ),
//     const SizedBox(
//       height: 16,
//     ),
//     Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         buildSocialIcon(FontAwesomeIcons.slack),
//         const SizedBox(
//           width: 12,
//         ),
//         buildSocialIcon(FontAwesomeIcons.github),
//         const SizedBox(
//           width: 12,
//         ),
//         buildSocialIcon(FontAwesomeIcons.twitter),
//         const SizedBox(
//           width: 12,
//         ),
//         buildSocialIcon(FontAwesomeIcons.linkedin),
//       ],
//     ),
//     const SizedBox(
//       height: 16,
//     ),
//     Divider(),
//     const SizedBox(
//       height: 16,
//     ),
//     const NumbersWidget(),
//     const SizedBox(
//       height: 16,
//     ),
//     // buildAbout(),
//     const SizedBox(
//       height: 10,
//     ),
//     Container(
//       padding: const EdgeInsets.symmetric(horizontal: 48),
//       child: const Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'About',
//             style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     ),
//     const SizedBox(height: 10,),
//     Container(
//       padding: const EdgeInsets.symmetric(horizontal: 50),
//       child: const Text(
//           "Haidy Ghonim is an Egyptian Lecturer and visual artist,"
//               "born and raised in Cairo, Egypt in 1991."
//               " In 2016,""she  received his BFA from the Graphic Design Department"
//               "in the Faculty of Fine Arts, Zamalek, she acquired his"
//               "MFA and she is preparing Ph.D. now from the same"
//               "university, Haidy studies focusing on body language  studies."),
//     ),
//   ],
// );
//
// Widget buildSocialIcon(IconData icon) => CircleAvatar(
//   radius: 25,
//   child: Material(
//     shape: const CircleBorder(),
//     clipBehavior: Clip.hardEdge,
//     color: Colors.transparent,
//     child: InkWell(
//         onTap: () {},
//         child: Center(
//           child: Icon(
//             icon,
//             size: 32,
//           ),
//         )),
//   ),
//   // );
// }
// }
