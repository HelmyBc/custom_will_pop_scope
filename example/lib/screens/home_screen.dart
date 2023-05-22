import 'package:example/locator.dart';
import 'package:example/navigation_service.dart';
import 'package:example/screens/router.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  void navigateToNext() {
    locator<NavigationService>().navigateTo(secondScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CustomWillPopScope Demo')),
      body: Center(
        child: ElevatedButton(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Text('Go to second screen'),
          ),
          onPressed: () => navigateToNext(),
        ),
      ),
    );
  }
}
