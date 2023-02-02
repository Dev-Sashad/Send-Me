import 'package:flutter/material.dart';

String? passwordValidator(String? value) {
  RegExp lowerCase = new RegExp(r'[a-z]');
  RegExp digit = new RegExp(r'[0-9]');

  if (!lowerCase.hasMatch(value!)) {
    return 'Password should contain figure and letters';
  }

  if (!digit.hasMatch(value)) {
    return 'Password should contain figure and letters';
  } else if ((value.length) < 8) {
    return 'password should contain 8 characters';
  } else
    return null;
}

String? emailValidator(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return 'Email format is invalid';
  } else if (value.isEmpty) {
    return 'enter email';
  } else
    return null;
}

String? phoneValidator(String? value) {
  String pattern = r"(^[\+]?[234]\d{12}$)";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return 'invalid phone number. e.g +2348012345678';
  } else if (value.isEmpty) {
    return 'enter phone number';
  } else if (value.length < 14) {
    return 'enter valid phone number';
  } else
    return null;
}

String? itemNameValidator(String? value) {
  RegExp upperCase = new RegExp(r'[A-Z]');

  if (!upperCase.hasMatch(value!)) {
    return 'Item name should start with caps';
  } else if (value.isEmpty) {
    return 'enter item name';
  } else
    return null;
}

String? stockValidator(String? value) {
  RegExp digit = new RegExp(r'[0-9]');

  if (!digit.hasMatch(value!)) {
    return 'enter only digits';
  } else if (value.isEmpty) {
    return 'enter quantity';
  } else
    return null;
}

bool validate(GlobalKey<FormState> formKey) {
  final form = formKey.currentState;
  if (form?.validate() ?? false) {
    form?.save();
    return true;
  } else {
    return false;
  }
}
