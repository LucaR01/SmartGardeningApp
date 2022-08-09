import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//TODO: rinominare file in flash_card o snackbar_card
//TODO: fare un enum con SnackBarColor.SUCCESS (verde) e FlashCardColor.ERROR (rosso)

class FlashErrorScreen extends StatelessWidget {
  const FlashErrorScreen({Key? key}) : super(key: key);

  //TODO: final String msg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Stack( //TODO: Wrap in a widget
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.red, //TODO: usare color constants o magari far inserire come parametro
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 48),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Oh snap!",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white, //TODO: use color constants
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "Flutter Snackbar",
                                  style: TextStyle(
                                    color: Colors.white, //TODO: use color constants
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                        child: SvgPicture.asset(
                          "assets/icons/bubbles.svg",
                          width: 40,
                          height: 48,
                          color: Colors.deepOrange, //TODO: use color constants rosso oscuro
                          ),
                      ),
                    ),
                    Positioned(
                      top: -20,
                      left: 0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/fail.svg",
                            height: 40,
                          ),
                          Positioned(
                            top: 10,
                            child: SvgPicture.asset(
                              "assets/icons/close.svg",
                              height: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
          }, 
          child: const Text("Show Message"),
        ),
      ),
    );
  }
}