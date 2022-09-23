import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';
import 'package:flutter_application_prova/screens/home/home_screen.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO: salvare nelle shared preferences la prima volta che vedi l'onboarding screen con un bool e poi non mostrarlo più

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
              title: AppLocalizations.of(context).scan, //TODO: update text; //TODO: use localizations
              body: '${AppLocalizations.of(context).scan_body}.',
              image: buildImage('assets/app_icon/Icon-48.png'), //TODO: update images
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: AppLocalizations.of(context).diagnosis, //TODO: Diagnosi oppure cura
              body: '${AppLocalizations.of(context).diagnosis_body}.',
              image: buildImage('assets/app_icon/Icon-48.png'),
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: AppLocalizations.of(context).cure,
              body: '${AppLocalizations.of(context).cure_body}.',
              image: buildImage('assets/app_icon/Icon-48.png'),
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: AppLocalizations.of(context).greener_is_more_beautiful,
              body: AppLocalizations.of(context).start_your_journey,
              footer: ElevatedButton(
                child: Text(AppLocalizations.of(context).get_started, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),
                onPressed: () => goToHome(context),
              ),
              image: buildImage('assets/app_icon/Icon-48.png'),
              decoration: getPageDecoration(context),
            ),
          ],
          done: Text(AppLocalizations.of(context).home, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green[900])), //TODO: Theme.of(context).textTheme.bodyText1!.color)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text(AppLocalizations.of(context).skip, style: TextStyle(color: Theme.of(context).accentIconTheme.color)), //TODO: use localizations
          onSkip: () { 
            goToHome(context);  
          },
          next: Icon(Icons.arrow_forward, color: Theme.of(context).accentIconTheme.color),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Colors.orange[500], //prima Colors.yellow[600], //TODO: Theme.of(context).primaryColor, // questo è il colore della barra
          skipFlex: 0,
          nextFlex: 0,
          //isProgressTap: false, // per non cliccare sui pulsantini
          // isProgress: false, // non mostra i pulsantini
          // showNextButton: false,
          //freeze: true,
          //animationDuration: 1000, // mostra un animazione tra le pagine
        ),
      );

  void goToHome(context) { 
    if(showOnBoarding != null && showOnBoarding == true) {
      showOnBoarding = false;
      UserPreferences.setShowOnBoarding(showOnBoarding!);
    }

    Utils.navigateToPage(context: context, page: Pages.home ); 
  }

  Widget buildImage(String path) => Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.green,//Color(0xFFBDBDBD),
        activeColor: Colors.green[900],
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration(BuildContext context) => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyText1!.color),
        bodyTextStyle: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyText1!.color),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Theme.of(context).scaffoldBackgroundColor, //prima era Colors.white; //TODO: Colors.green[700]
      );
}