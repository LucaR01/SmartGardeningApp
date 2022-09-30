import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_gardening_app/widgets/app_bar/app_bar.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: FutureBuilder(
        future: rootBundle.loadString("assets/terms_and_conditions/terms_and_conditions.md"),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if(snapshot.hasData) {
            return Markdown(data: snapshot.data!, );
          }

          return const Center(
            child: CircularProgressIndicator(), //TODO: volendo usare SpinKit
          );
        }
      ),
    );
  }
}