import 'package:flutter/material.dart';

class CustomScrollWidget extends StatelessWidget {
  final Widget? child;
  final Axis scrollDirection;
  CustomScrollWidget({this.child, this.scrollDirection = Axis.vertical});
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          scrollDirection: scrollDirection,
          child: child,
        ));
  }
}
