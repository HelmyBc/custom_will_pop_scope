import 'package:flutter/material.dart';

class NavigationService {
  List<String> _routeNames = List<String>.empty(growable: true);
  List<String> get routeNames => _routeNames;

  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  GlobalKey<NavigatorState> _commentsNavigationKey =
      GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get commentsNavigationKey => _commentsNavigationKey;

  /// get last route name in the list
  String getCurrentRouteName() {
    return _routeNames.last;
  }

 
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
    if (_routeNames.isNotEmpty){
      removeLastRouteName();
      _navigationKey.currentState.pop(args);
      print("************************** pop $_routeNames");
      }
  }

  /// pop route without delete it in the list
  void popWithoutRouteName({dynamic args}) {
    _navigationKey.currentState.pop(args);
    print("************************** popWithoutRouteName $_routeNames");
  }

  void popUntilFirstRoute() {
    if (_routeNames.length > 1) {
      _routeNames.removeRange(1, _routeNames.length);
    }
    _navigationKey.currentState.popUntil((route) => route.isFirst);
    print("************************** popUntilFirstRoute $_routeNames");
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    addRouteName(routeName);
    print("************************** navigateTo $_routeNames");
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAndPop(String routeName, {dynamic arguments}) {
    removeLastRouteName();
    addRouteName(routeName);
    print("************************** navigateToAndPop $_routeNames");
    return _navigationKey.currentState
        .popAndPushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAllAndNavigateTo(String routeName, {dynamic arguments}) {
    _routeNames.clear();
    addRouteName(routeName);
    print("************************** popAllAndNavigateTo $_routeNames");
    return _navigationKey.currentState.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  Future<dynamic> navigateToAndPopUntil(String routeName, String routeToPop,
      {dynamic arguments}) {
    while (_routeNames[_routeNames.length - 1] != routeToPop) {
      _routeNames.removeLast();
    }
    _routeNames.add(routeName);
    print(
        "************************** navigateToAndPopUntil $_routeNames");
    return _navigationKey.currentState.pushNamedAndRemoveUntil(
        routeName, ModalRoute.withName(routeToPop),
        arguments: arguments);
  }



  // /// This method updates the analytics by calling [ExternalAnalyticsService.trackScreenView]
  // /// method with the current route name. It first checks if the [_routeNames] list is
  // /// not empty and then gets the current route name by calling the [extractRouteName]
  // /// method with the last item in the [_routeNames] list.
  // void updateAnalytics(){
  //   if(_routeNames.isNotEmpty){
  //     String currentRouteName = extractRouteName(_routeNames.last);
  //     _analyticsService.trackScreenView(screenName: currentRouteName);
  //   }
  // }


  /// This method returns the previous screen route as String, i.e., the route name of the
  /// screen that was navigated to before the current screen. If the [_routeNames] list
  /// has more than one item, it returns the second-to-last item in the list. Otherwise,
  /// it returns null.
  String getPreviewsScreenRoute(){
    if(_routeNames.length > 1){
      return _routeNames[_routeNames.length - 2];
    }
    return null;
  }

}
