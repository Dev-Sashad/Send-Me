import 'package:flutter/material.dart';
import 'package:send_me/ui/dashboard/dashboard.dart';
import '../_lib.dart';

Route<dynamic> generateRoute(RouteSettings? settings) {
  switch (settings!.name) {
    case splashScreenViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: SplashScreen(),
      );

    case loginViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: Login(),
      );

    case registerViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: Registration(),
      );

    case forogtPassViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ForgotPassword(),
      );

    case forgotPassSuccessRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResetPassSuccess(),
      );

    case regSuccessViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: RegistrationSuccess(),
      );

    case dashboardViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: Dashboard(),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String? routeName, Widget? viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow!);
}
