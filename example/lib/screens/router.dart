import 'package:example/screens/home_screen.dart';
import 'package:example/screens/second_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              ));
  }
}

getPageRoute(Widget viewToShow) {
  return CupertinoPageRoute(builder: (context) {
    return viewToShow;
  });
  // if (Platform.isIOS) {
  //   return CupertinoPageRoute(
  //       builder: (BuildContext context) => viewToShow,
  //       settings: RouteSettings(arguments: args, name: viewToShow.toString()));
  // } else
  // return PageTransition(
  //     child: viewToShow,
  //     type: transitionAnimation,
  //     settings: RouteSettings(arguments: args, name: viewToShow.toString()));
}


const homeScreen ="Home Screen";
const secondScreen ="Second Screen";
