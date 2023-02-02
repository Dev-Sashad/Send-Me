import 'package:flutter/material.dart';

class DismissableKeyboardFeature extends StatefulWidget {
  final Widget? child;
  const DismissableKeyboardFeature({Key? key, @required this.child})
      : super(key: key);

  @override
  State<DismissableKeyboardFeature> createState() =>
      _DismissableKeyboardFeatureState();
}

class _DismissableKeyboardFeatureState extends State<DismissableKeyboardFeature>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: widget.child,
    );
  }
}
