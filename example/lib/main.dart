import 'package:custom_will_pop_scope/custom_will_pop_scope.dart';
import 'package:example/locator.dart';
import 'package:example/navigation_service.dart';
import 'package:example/router.dart' as router;
import 'package:example/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final theme = ThemeData(
    primarySwatch: Colors.blue,
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

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final Color _color = Colors.pink;
  final NavigationService _navigationService = locator<NavigationService>();

  /// Holds the state of the screen.
  bool _canReturn = true;

  /// Shows an alert and returns `false` when `_canReturn` is `true`.
  /// This prevents the navigator from popping this route.
  Future<bool> _onWillPop() async {
    if (!_canReturn) {
      // // Show an alert before returning `false`.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Back navigation is disabled.'),
        ),
      );
      // Return `false` to prevent the route from popping.
      return false;
    } else {
      _navigationService.removeLastRouteName();
      return true;
    }
  }

  void _onPopAction() {
    _navigationService.removeLastRouteName();
  }

  /// Updates `_canReturn` with the provided value.
  void _updateChanges(bool value) => setState(() => _canReturn = value);

  @override
  Widget build(BuildContext context) {
    return CustomWillPopScope(
      // canReturn is optional, it is set to true by default
      canReturn: _canReturn,
      onWillPop: _onWillPop,
      onPopAction: _onPopAction,
      child: Scaffold(
        appBar: AppBar(title: Text('Second Screen'), backgroundColor: _color),
        body: Center(
          child: Container(
            child: SwitchListTile(
              activeColor: _color,
              onChanged: _updateChanges,
              title: Text('Enable back navigation'),
              value: _canReturn,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: _color),
              borderRadius: BorderRadius.circular(6.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.0),
          ),
        ),
      ),
    );
  }
}
