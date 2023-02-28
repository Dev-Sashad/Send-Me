import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/local_data_request/local_data_request.dart';
import 'package:send_me/core/local_data_request/local_url.dart';
import 'package:send_me/core/model/base_response.dart';

abstract class AuthRepo {
  Future<BaseResponse> getCurrentUser();
  Future<BaseResponse> signUp({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
  });
  Future<BaseResponse> signIn(
      {required String email, required String password});
  Future<BaseResponse> forgotPassword({required String email});
  Future<BaseResponse> resetPassword(
      {required String oldPassword, required String newPassword});
  Future<BaseResponse> updateUserProfile(
      {String? name, String? email, String? phoneNumber, User? user});
  Future<dynamic> signOut();
}

class AuthRepoImpl extends AuthRepo {
  final LocalDataRequest _localDataRequest;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  AuthRepoImpl(this._localDataRequest);
  @override
  Future<BaseResponse> getCurrentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        if (user.emailVerified) {
          appPrint('the user id is ${user.uid.toString()}');
          String userIdentity = user.uid.toString();
          String userName = user.displayName.toString();
          await _localDataRequest.setString(AppLocalUrl.userId, userIdentity);
          await _localDataRequest.setString(AppLocalUrl.userName, userName);
          return BaseResponse(status: true, message: 'successful', data: user);
        } else {
          await signOut();
          return BaseResponse(status: false, message: 'error');
        }
      } else {
        return BaseResponse(status: false, message: 'error');
      }
    } on SocketException {
      return BaseResponse(status: false, message: 'check internet connection');
    } catch (e) {
      return BaseResponse(status: false, message: 'error');
    }
  }

  Future updateUserName(String name, User currentUser) async {
    await currentUser.updateDisplayName(name);
    await currentUser.reload();
  }

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map((user) => user!.uid);

  @override
  Future<BaseResponse> signUp(
      {required String email,
      required String password,
      required String userName,
      required String phoneNumber}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (response.user!.email != null) {
        await updateUserProfile(
            name: userName,
            email: email,
            phoneNumber: phoneNumber,
            user: response.user);
        await response.user!.sendEmailVerification();
        return BaseResponse(
            status: true,
            title: "SignUp Successful",
            message: 'verfication mail has been to this email');
      } else {
        return BaseResponse(status: false, message: 'an error occured');
      }
    } on FirebaseAuthException catch (msg) {
      if (msg.code == 'weak-password') {
        return BaseResponse(
            status: false, message: 'The password provided is too weak');
      } else if (msg.code == 'email-already-in-use') {
        return BaseResponse(status: false, message: 'user already exist');
      } else {
        appPrint(msg.message);
        return BaseResponse(
            status: false, message: 'SignUp failed. Kindly contact support');
      }
    } on SocketException {
      return BaseResponse(status: false, message: 'check internet connection');
    } catch (e) {
      return BaseResponse(status: false, message: 'an error occured');
    }
  }

  @override
  Future<BaseResponse> signIn(
      {required String email, required String password}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = response.user;
      if (user!.displayName != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return BaseResponse(
            status: false,
            title: "account not verified",
            message: "verfication mail has been to this email");
      } else {
        String userIdentity = user.uid.toString();
        String userName = user.displayName.toString();
        await _localDataRequest.setString(AppLocalUrl.userId, userIdentity);
        await _localDataRequest.setString(AppLocalUrl.userName, userName);
        await _localDataRequest.setString(AppLocalUrl.password, password);
        return BaseResponse(status: true, message: 'successful', data: user);
      }
    } on FirebaseAuthException catch (msg) {
      if (msg.code == 'user-not-found') {
        return BaseResponse(status: false, message: "user does not exist");
      } else if (msg.code == 'wrong-password') {
        return BaseResponse(status: false, message: "Wrong password");
      } else {
        return BaseResponse(status: false, message: msg.message);
      }
    } on SocketException {
      return BaseResponse(status: false, message: 'check internet connection');
    } catch (e) {
      return BaseResponse(status: false, message: 'an error occured');
    }
  }

  @override
  Future<BaseResponse> updateUserProfile(
      {String? name, String? email, String? phoneNumber, User? user}) async {
    try {
      await user!.updateDisplayName(name);
      await user.reload();
      await firestoreInstance.runTransaction((Transaction transaction) async {
        DocumentReference reference =
            firestoreInstance.collection('users').doc(user.uid);
        await reference.set({
          "name": name,
          "email": email,
          "phoneNumber": phoneNumber,
          "userId": user.uid,
        });
      });
      return BaseResponse(status: true, message: 'Profile update successful');
    } on SocketException {
      return BaseResponse(status: false, message: 'check internet connection');
    } catch (e) {
      return BaseResponse(status: false, message: 'an error occured');
    }
  }

  @override
  Future<BaseResponse> forgotPassword({required String email}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return BaseResponse(
          status: true, message: 'Link to reset password has been sent');
    } on FirebaseAuthException catch (msg) {
      return BaseResponse(
          status: false, message: msg.message ?? 'invalid email');
    } on SocketException {
      return BaseResponse(status: false, message: 'check internet connection');
    } catch (e) {
      return BaseResponse(status: false, message: 'an error occured');
    }
  }

  Future singInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  @override
  Future<BaseResponse> resetPassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      String getoldPassword =
          await _localDataRequest.getString(AppLocalUrl.password) ?? "";
      if (getoldPassword.trim() != oldPassword.trim()) {
        return BaseResponse(
            status: false, message: 'wrong old password', title: '');
      } else {
        User? user = FirebaseAuth.instance.currentUser;
        await user!.updatePassword(newPassword);
        await _localDataRequest.setString(AppLocalUrl.password, newPassword);
        return BaseResponse(
            status: true, message: 'Password successfully changed');
      }
    } on FirebaseAuthException catch (msg) {
      if (msg.code == 'weak-password') {
        return BaseResponse(
            status: false,
            title: 'Weak password',
            message: "user a stronger passoword");
      } else {
        return BaseResponse(status: false, message: msg.message);
      }
    } on SocketException {
      return BaseResponse(status: false, message: 'check internet connection');
    } catch (e) {
      appPrint(e);
      return BaseResponse(status: false, message: 'an error occured');
    }
  }

  @override
  Future signOut() async {
    await _localDataRequest.removeAll();
    await _firebaseAuth.signOut().then((value) => onAuthStateChanged);
  }
}

class NameValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class EmailValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }
}
