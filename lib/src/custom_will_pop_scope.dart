import 'package:flutter/material.dart';

class CustomWillPopScope extends StatelessWidget {
  final Widget child;
  final bool canReturn;
  final Future<bool> Function() onWillPop;
  final void Function() onPopAction;

  const CustomWillPopScope({
    Key? key,
    required this.child,
    required this.onWillPop,
    this.canReturn = true,
    required this.onPopAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) {
        if (canReturn &&
            (details.velocity.pixelsPerSecond.dx < 0 ||
                details.velocity.pixelsPerSecond.dx > 0) &&
            Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          onPopAction();
        }
      },
      child: WillPopScope(
        onWillPop: onWillPop,
        child: child,
      ),
    );
  }
}
