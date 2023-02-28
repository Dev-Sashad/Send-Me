// ignore_for_file: prefer_function_declarations_over_variables

final bool Function(String) emailRegEx = (String emailText) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(emailText);
};

final bool Function(String) emailorphoneRegEx = (String text) {
  return emailRegEx(text) || phoneRegEx(text);
};

final bool Function(String) phoneRegEx = (String phone) {
  return RegExp(r"^[0-9]").hasMatch(phone);
};
String? Function(String) emailPhoneVal = (val) {
  if (val.isEmpty) {
    return 'Please enter e-mail or phone number';
  } else if (emailorphoneRegEx(val)) {
    return null;
  } else {
    return 'Enter a valid e-mail or phone number';
  }
};

String? Function(String?)? phoneVal = (val) {
  if (val!.trim().isEmpty) {
    return 'Please enter  phone number';
  } else if (phoneRegEx(val) && val.length == 10) {
    return null;
  } else {
    return 'Enter a valid phone number';
  }
};

String? Function(String) emailVal = (val) {
  if (val.isEmpty) {
    return 'Please enter your e-mail';
  } else if (emailRegEx(val)) {
    return null;
  } else {
    return 'Enter a valid e-mail';
  }
};

String? Function(String) paymentVal = (val) {
  RegExp digit = RegExp(r'[0-9]');
  String error = 'enter a valid amount';
  String reject = 'minimum amount is NGN 1000';
  if (!digit.hasMatch(val)) {
    return error;
  } else if (val.length < 3 || int.parse(val) < 1000) {
    return reject;
  }
  //  if (int.parse(val) < 1000) {
  //   return reject;
  // }

  else {
    return null;
  }
};
