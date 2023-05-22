
import 'package:flutter/material.dart';

import 'cupertino_page_route.dart';

class CustomWillPopScopePageTransitionsBuilder extends PageTransitionsBuilder {
  const CustomWillPopScopePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return CupertinoRouteTransitionMixin.buildPageTransitions<T>(
        route, context, animation, secondaryAnimation, child);
  }
}
