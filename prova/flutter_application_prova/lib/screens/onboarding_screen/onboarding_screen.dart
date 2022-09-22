import 'package:flutter/material.dart';
import 'package:flutter_application_prova/screens/home/home_screen.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';

import 'package:introduction_screen/introduction_screen.dart';

//TODO: salvare nelle shared preferences la prima volta che vedi l'onboarding screen con un bool e poi non mostrarlo più

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key); //TODO: remove?

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'A reader lives a thousand lives', //TODO: update text; //TODO: use localizations
              body: 'The man who never reads lives only one.',
              image: buildImage('assets/app_icon/Icon-48.png'), //TODO: update images
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: 'Featured Books',
              body: 'Available right at your fingerprints',
              image: buildImage('assets/app_icon/Icon-48.png'),
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: 'Simple UI',
              body: 'For enhanced reading experience',
              image: buildImage('assets/app_icon/Icon-48.png'),
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: 'Today a reader, tomorrow a leader',
              body: 'Start your journey',
              footer: ElevatedButton(
                child: Text('Get Started', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),
                onPressed: () => goToHome(context),
              ),
              image: buildImage('assets/app_icon/Icon-48.png'),
              decoration: getPageDecoration(context),
            ),
          ],
          done: Text('Home', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green[900])), //TODO: Theme.of(context).textTheme.bodyText1!.color)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text('Skip', style: TextStyle(color: Theme.of(context).accentIconTheme.color)), //TODO: use localizations
          onSkip: () => goToHome(context),
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

  /*void goToHome(context) => Navigator.of(context).pushReplacement( //TODO: chimaare Utils.
        MaterialPageRoute(builder: (_) => HomePage()),
  );*/

  void goToHome(context) => Utils.navigateToPage(context: context, page: Pages.home );

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