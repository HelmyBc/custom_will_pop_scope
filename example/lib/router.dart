
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeScreen:
      return getPageRoute(HomeScreen());
    case secondScreen:
      return getPageRoute(SecondScreen());

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text("No route defined for ${settings.name}"),
                ),
              ),);
  }
}

getPageRoute(Widget viewToShow) {
  return CupertinoPageRoute(builder: (context) {
    return viewToShow;
  });
}


const homeScreen ="Home Screen";
const secondScreen ="Second Screen";
