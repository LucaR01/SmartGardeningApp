import 'package:flutter/material.dart';

import 'package:flutter_application_prova/constants/constants.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';
import 'package:flutter_application_prova/provider/theme_provider.dart';
import 'package:flutter_application_prova/screens/home/home_screen.dart';
import 'package:flutter_application_prova/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart'; // Per le PageTransitionType

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? showOnBoarding = UserPreferences.getShowOnBoarding();

  bool? isDarkTheme; //TODO: retrieve isDarkTheme

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column( //TODO: add Center Widget?
          children: [
            Text(Constants.appName, style: TextStyle(fontSize: 36, color: Theme.of(context).textTheme.bodyText1!.color,)),
            //Image.asset('assets/app_icon/Icon-192.png'), //TODO: remove
            //TODO: Theme.of(context).scaffoldBackgroundColor == Colors.white ? Image.asset('assets/app_icon/Icon-192.png') : Image.asset('assets/app_icon/Icon-dark-192.png'), //TODO: recuperare dal isDarkTheme
            Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? Image.asset('assets/app_icon/Icon-dark-192.png') : Image.asset('assets/app_icon/Icon-192.png'),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, //TODO: oppure verde, verde-scuro
      //TODO: volendo usare Utils.navigateToPage()
      nextScreen: showOnBoarding != null && showOnBoarding == false ? HomePage() : const OnBoardingPage(), //OnBoardingPage(), //TODO: const HomePage(), //TODO: dovrà essere showOnBoarding == false ? HomePage() : OnBoardingPage(),
      splashIconSize: 256, //TODO: prima era 250
      duration: 4000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}