import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  User? _user;
  User? get user => _user;
  set newUser(User? value) {
    _user = value;
  }
}
