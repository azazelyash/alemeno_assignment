// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:alemeno_assignment/screens/feedscreen.dart';
import 'package:alemeno_assignment/widgets/glassmorphism.dart';
import 'package:alemeno_assignment/widgets/themebutton.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? imageURL;
  String buttonText = "Click  your  meal!";
  String animalImageURL = 'assets/simba.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestCameraPermission();
    imageURL = null;
  }

  void requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      print("Granted");
    } else if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        print("Permission Granted");
      } else {
        openAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            image: const AssetImage('assets/background.jpg'),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 16.0,
                  ),
                  child: Image(
                    width: MediaQuery.of(context).size.width * 0.4,
                    image: AssetImage(animalImageURL),
                  ),
                ),
                GlassMorphism(
                  theChild: Column(
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Image(
                            image: AssetImage('assets/Fork.png'),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          (imageURL != null)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.network(
                                    imageURL!,
                                    height: 200.0,
                                    width: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const CircleAvatar(
                                  radius: 100,
                                  backgroundColor:
                                      Color.fromARGB(255, 102, 102, 102),
                                  child: Icon(
                                    Icons.image,
                                    size: 64,
                                    color: Colors.black54,
                                  ),
                                ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Image(
                            image: AssetImage('assets/Spoon.png'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 48,
                      ),

                      /* ----------------------------- Camera Function ---------------------------- */

                      ThemeButton(
                        onPressed: () async {
                          /* --------------------------------- Camera --------------------------------- */

                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(
                            source: ImageSource.camera,
                            preferredCameraDevice: CameraDevice.rear,
                          );

                          if (file == null) {
                            return;
                          }

                          String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          /* -------------------------------- Firebase -------------------------------- */

                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImage =
                              referenceRoot.child('images');
                          Reference referenceImageToUpload =
                              referenceDirImage.child(uniqueFileName);

                          try {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xff65AC3A),
                                    ),
                                  );
                                });

                            await referenceImageToUpload
                                .putFile(File(file.path));
                            imageURL =
                                await referenceImageToUpload.getDownloadURL();

                            Navigator.of(context).pop();

                            /* ------------------------------- Change Page ------------------------------ */

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FeedSimba(imageURL: imageURL!),
                              ),
                            );
                          } catch (e) {}
                        },
                        childText: buttonText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
