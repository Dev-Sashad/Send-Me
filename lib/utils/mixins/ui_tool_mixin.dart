import 'package:send_me/_lib.dart';
import 'package:send_me/core/services/auth_data_service.dart';
import 'package:send_me/core/services/navigation_service.dart';

mixin UIToolMixin {
  final NavigationService navigationService = locator<NavigationService>();
  final AuthService authService = locator<AuthService>();
}
