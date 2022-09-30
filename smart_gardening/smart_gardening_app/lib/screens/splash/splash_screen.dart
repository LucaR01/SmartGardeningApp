import 'package:flutter/material.dart';

import 'package:smart_gardening_app/constants/constants.dart';
import 'package:smart_gardening_app/models/shared_preferences/user_preferences.dart';
import 'package:smart_gardening_app/provider/theme_provider.dart';
import 'package:smart_gardening_app/screens/home/home_screen.dart';
import 'package:smart_gardening_app/screens/onboarding_screen/onboarding_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column( 
          children: [
            Text(Constants.appName, style: TextStyle(fontSize: 36, color: Theme.of(context).textTheme.bodyText1!.color,)),
            Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? Image.asset('assets/app_icon/Icon-dark-192.png') : Image.asset('assets/app_icon/Icon-192.png'),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      nextScreen: showOnBoarding != null && showOnBoarding == false ? const HomePage() : const OnBoardingPage(), // non posso utilizzare Utils.navigateToPage() perché vuole un Widget non un void
      splashIconSize: 256,
      duration: 4000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}