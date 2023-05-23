import 'package:custom_will_pop_scope/custom_will_pop_scope.dart';
import 'package:example/locator.dart';
import 'package:example/navigation_service.dart';
import 'package:example/screens/home_screen.dart';
import 'package:example/screens/router.dart' as router;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final theme = ThemeData(
    primarySwatch: Colors.blue,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomWillPopScopePageTransitionsBuilder(),
        TargetPlatform.iOS: CustomWillPopScopePageTransitionsBuilder(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    setupLocator();
    return MaterialApp(
      theme: theme,
      home: HomeScreen(),
      initialRoute: router.homeScreen,
      onGenerateRoute: router.generateRoute,
      navigatorKey: locator<NavigationService>().navigationKey,
    );
  }
}
