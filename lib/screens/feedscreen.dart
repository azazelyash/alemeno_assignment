import 'package:alemeno_assignment/widgets/glassmorphism.dart';
import 'package:alemeno_assignment/widgets/themebutton.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class FeedSimba extends StatefulWidget {
  const FeedSimba({super.key, required this.imageURL});

  final String imageURL;

  @override
  State<FeedSimba> createState() => _FeedSimbaState();
}

class _FeedSimbaState extends State<FeedSimba> {
  String animalImageURL = "assets/simba.png";
  String buttonText = "Feed this to Simba";

  void updateUI() {
    setState(() {
      animalImageURL = "assets/mufasa.png";
    });
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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton.small(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: const Color(0xff65AC3A),
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
                Column(
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
                              // ignore: unnecessary_null_comparison
                              (widget.imageURL != null)
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: Image.network(
                                        widget.imageURL,
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
                            onPressed: () {
                              /* ----------------------------- Button Function ---------------------------- */
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: Color(0xff65AC3A),
                                    ));
                                  });
                              updateUI();

                              Navigator.of(context).pop();

                              QuickAlert.show(
                                confirmBtnColor: const Color(0xff65AC3A),
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Good Job',
                                autoCloseDuration: const Duration(seconds: 5),
                              );
                            },
                            childText: buttonText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
