import 'package:flutter/material.dart';

/// An alternative of [WillPopScope] that enable the iOS swipe to return.
class CustomWillPopScope extends StatelessWidget {
  /// Creates a widget that registers a callback to veto attempts by the user to
  /// dismiss the enclosing [ModalRoute].
  ///
  /// The `child`,`onWillPop` and `onPopAction` arguments must not be `null`.
  const CustomWillPopScope({
    Key? key,
    required this.child,
    required this.onWillPop,
    this.canReturn = true,
    this.onPopAction,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  /// Whether the navigator that most tightly encloses the given context can be
  /// popped.
  final bool canReturn;

  ///Called to veto attempts by the user to dismiss the enclosing [ModalRoute].
  ///If the callback returns a Future that resolves to false, the enclosing route will not be popped.
  final Future<bool> Function() onWillPop;

  /// Called when dissmissing the enclosing [ModalRoute].
  final void Function()? onPopAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) {
        // Enables the iOS return swipe according to some conditions
        if (canReturn &&
            (details.velocity.pixelsPerSecond.dx < 0 ||
                details.velocity.pixelsPerSecond.dx > 0) &&
            Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          if (onPopAction != null) {
            onPopAction!();
          }
        }
      },
      child: WillPopScope(
        onWillPop: onWillPop,
        child: child,
      ),
    );
  }
}
