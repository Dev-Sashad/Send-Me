import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop() {
    return _navigationKey.currentState!.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateReplacementTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<Object?> pushAndRemoveUntil<T extends Object>(String newRoute) {
    return _navigationKey.currentState!
        .pushNamedAndRemoveUntil(newRoute, (Route<dynamic> route) => false);
  }

  Future<dynamic> popUntil(String routeName) async {
    return _navigationKey.currentState!
        .popUntil(ModalRoute.withName(routeName));
  }

  replaceCurrent(
    Widget widget,
  ) {
    final anchor = ModalRoute.of(_navigationKey.currentState!.context);
    final page = MaterialPageRoute(builder: (context) => widget);

    _navigationKey.currentState!.replace(oldRoute: anchor!, newRoute: page);
  }

  pushScreen(Widget widget) {
    _navigationKey.currentState!
        .push(MaterialPageRoute(builder: (context) => widget));
  }
}
