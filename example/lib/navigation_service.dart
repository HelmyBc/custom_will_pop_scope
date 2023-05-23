import 'package:flutter/material.dart';

class NavigationService {
  List<String> _routeNames = List<String>.empty(growable: true);
  List<String> get routeNames => _routeNames;

  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  /// add route in list
  void addRouteName(String route) {
    _routeNames.add(route);
    print("************************** addRouteName $_routeNames");
  }

  /// delete last route name in list
  void removeLastRouteName() {
    if (_routeNames.isNotEmpty) {
      _routeNames.removeLast();
    }
    print("************************** removeLastRouteName $_routeNames");
  }

  Future<void> pop({dynamic args}) async {
    if (_routeNames.isNotEmpty) {
      removeLastRouteName();
      _navigationKey.currentState!.pop(args);
      print("************************** pop $_routeNames");
    }
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    addRouteName(routeName);
    print("************************** navigateTo $_routeNames");
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }
}
