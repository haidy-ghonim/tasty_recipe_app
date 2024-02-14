import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:tasty_recipe_app/provider/app_auth.provider.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final AppAuthProvider authProvider = AppAuthProvider();

  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).providerInit();
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Consumer<AppAuthProvider>(
          builder: (context, authProvider, _) => Form(
            key: authProvider.formKey,
            child: Container(
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
                            'https://lottie.host/2adf013a-659e-4c6a-96f3-4a5fec2c27e6/g1EC3MyqEY.json'),
                        const SizedBox(
                          height: 11,
                        ),
                        Container(
                          child: Positioned(
                            top: 135,
                            child: Container(
                              width: 135,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL
                                      .toString(),
                                )),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Positioned(
                          top: 240,
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.only(left: 50, bottom: 40),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.lime),
                            //todo image upload
                            child: InkWell(
                              onTap: () async {
                                OverlayLoadingProgress.start();
                                var imageResult =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                  withData: true,
                                );
                                var refrence = FirebaseStorage.instance
                                    .ref(
                                        'profile/${imageResult?.files.first.name}')
                                    .child('image_file');
                                if (imageResult?.files.first.bytes != null) {
                                  var uploadResult = await refrence.putData(
                                      imageResult!.files.first.bytes!,
                                      SettableMetadata(
                                          contentType: 'image/png'));
                                  if (uploadResult.state == TaskState.success) {
                                    print(
                                        'image upload successfully ${await refrence.getDownloadURL()}');

                                    final String downloadURl =
                                        await refrence.getDownloadURL();
                                    authProvider.updatePhotoURL(downloadURl);
                                  }
                                }
                                OverlayLoadingProgress.stop();
                              },
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    //todo First Name
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextFormField(
                        controller: authProvider.firstnameController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blueGrey,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Full Name",
                          fillColor: Colors.blueGrey,
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your FirstName';
                          }
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    //todo Age
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextFormField(
                        // controller: authProvider.phonenumberController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Age';
                          }
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blueGrey,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(
                            Icons.account_box,
                            color: Colors.white,
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Age",
                          fillColor: Colors.blueGrey,
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //todo Phone Number
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextFormField(
                        // controller: authProvider.phonenumberController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Phone Number';
                          }
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blueGrey,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Phone Number",
                          fillColor: Colors.blueGrey,
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              // if(! context.read<AppAuthProvider>()
                              //     .formKey!.currentState!.validate()){
                              //   return;
                              //
                              // } context.read<AppAuthProvider>().formKey?.currentState!.save();
                              // if (!authProvider.formKey!.currentState!
                              //     .validate()) {
                              //   return;
                              // }
                              // authProvider.formKey?.currentState!.save();
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 2.2,
                                color: Colors.orange,
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
          ),
        ),
      ),
    );
  }
}
