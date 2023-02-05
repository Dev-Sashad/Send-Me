import 'package:flutter/material.dart';

class CustomScrollWidget extends StatelessWidget {
  final Widget? child;
  final Axis scrollDirection;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  const CustomScrollWidget(
      {Key? key,
      this.child,
      this.scrollDirection = Axis.vertical,
      this.physics,
      this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          scrollDirection: scrollDirection,
          controller: controller,
          physics: physics,
          child: child,
        ));
  }
}
