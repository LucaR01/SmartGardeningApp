import 'package:flutter/material.dart';
import 'package:flutter_application_prova/constants/colors_constants.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  bool? showOnBoarding = UserPreferences.getShowOnBoarding();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: AppLocalizations.of(context).scan,
              body: '${AppLocalizations.of(context).scan_body}.',
              image: buildImage('assets/onboarding/plant_magnifier.png', Theme.of(context).accentIconTheme.color),
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: AppLocalizations.of(context).diagnosis, 
              body: '${AppLocalizations.of(context).diagnosis_body}.',
              image: buildImage('assets/onboarding/dying_plant.png', Theme.of(context).accentIconTheme.color),
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: AppLocalizations.of(context).cure,
              body: '${AppLocalizations.of(context).cure_body}.',
              image: buildImage('assets/onboarding/sick-leave.png', Theme.of(context).accentIconTheme.color), 
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: AppLocalizations.of(context).greener_is_more_beautiful, //TODO: piuttosto potrei mettere qualcosa riguardo il sensore! 
              body: AppLocalizations.of(context).start_your_journey, //TODO: Collect your's sensors data
              footer: ElevatedButton(
                child: Text(AppLocalizations.of(context).get_started, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),
                onPressed: () => goToHome(context),
              ),
              image: buildImage('assets/onboarding/Ecology-01-01-1024.png'),
              decoration: getPageDecoration(context),
            ),
          ],
          done: Text(AppLocalizations.of(context).home, style: TextStyle(fontWeight: FontWeight.w600, color: ColorConstants.onBoardingDoneTextColor)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text(AppLocalizations.of(context).skip, style: TextStyle(color: Theme.of(context).accentIconTheme.color)), 
          onSkip: () { 
            goToHome(context);  
          },
          next: Icon(Icons.arrow_forward, color: Theme.of(context).accentIconTheme.color),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: ColorConstants.onBoardingGlobalBackgroundColor,
          skipFlex: 0,
          nextFlex: 0,
          //isProgressTap: false, // per non cliccare sui pulsantini
          // isProgress: false, // non mostra i pulsantini
          // showNextButton: false,
          //freeze: true,
          //animationDuration: 1000, // mostra un animazione tra le pagine
        ),
      );

  /// If the [showOnBoarding] is not null and it is true then it updates the value of [showOnBoarding] to false
  /// and save it in the [UserPreferences] then it moves to page: [Pages.home].
  void goToHome(context) { 
    if(showOnBoarding != null && showOnBoarding == true) {
      showOnBoarding = false;
      UserPreferences.setShowOnBoarding(showOnBoarding!);
    }

    Utils.navigateToPage(context: context, page: Pages.home ); 
  }

  /// It builds an image based on the image's [path] and the eventual, optioanl [color] passed as arguments.
  Widget buildImage(String path, [Color? color]) => Center(child: Image.asset(path, width: 350, color: color,));

  /// It returns the dots on the bottom of the screen to swap pages.
  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.green,
        activeColor: Colors.green[900],
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  /// It update the style of the title and body of the page.
  PageDecoration getPageDecoration(BuildContext context) => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyText1!.color),
        bodyTextStyle: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyText1!.color),
        descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
        pageColor: Theme.of(context).scaffoldBackgroundColor,
      );
}