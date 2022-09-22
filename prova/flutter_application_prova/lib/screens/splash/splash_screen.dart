import 'package:flutter/material.dart';

import 'package:flutter_application_prova/constants/strings_constants.dart';
import 'package:flutter_application_prova/screens/home/home_screen.dart';
import 'package:flutter_application_prova/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart'; // Per le PageTransitionType

//TODO: rename class in SplashScreen?

//TODO: add a gradient.
//TODO: add animation effect.
//TODO: Add some plants

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  static String routeName = "/splash";

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> { //TODO: remove?
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1800), () {});
    Utils.navigateToPage(context: context, page: Pages.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(top: 60.0, right: 30.0),
          child: Text(
            kAppName,
            style: TextStyle(
              fontSize: 36,
              //fontFamily: 'RailWay'
              color: Theme.of(context).textTheme.bodyText1!.color,
              )
            )
          /*child: Column(
            children: <Widget> [
              Text(
              kAppName,
              style: TextStyle(
                fontSize: 36,
                //fontFamily: 'RailWay'
                color: Theme.of(context).textTheme.bodyText1!.color,
              )),
              Container(
                child: Image.asset('assets/'),
              ),
            ],
          ),*/
        ),
      )
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column( //TODO: add Center Widget?
          children: [
            Text('Smart Gardening', style: TextStyle(fontSize: 36, color: Theme.of(context).textTheme.bodyText1!.color,)), //TODO: use string constants
            Image.asset('assets/app_icon/Icon-192.png'), //TODO: Theme.of(context).scaffoldBackgroundColor == Colors.white ? Image.asset('') : Image.asset(''),
            //Text('Smart Gardening', style: TextStyle(fontSize: 36, color: Theme.of(context).textTheme.bodyText1!.color,)), //TODO: use string constants
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, //TODO: oppure verde, verde-scuro
      nextScreen: OnBoardingPage(), //TODO: const HomePage(), //TODO: dovrà essere showOnBoarding == false ? HomePage() : OnBoardingPage(),
      splashIconSize: 256, //TODO: prima era 250
      duration: 4000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}