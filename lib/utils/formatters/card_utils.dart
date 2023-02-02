class CardUtils {
  static String? validateCvv(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    if (value.length != 3) {
      return 'CVV is invalid';
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    int year;
    int month;
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1;
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }

    var fourDigitsYear = _convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }

    if (!_hasDateExpired(month, year)) {
      return 'Card has expired';
    }
    return null;
  }

  static String? validateCardNumber(String? input) {
    if (input == null || input.isEmpty) {
      return 'This field is required';
    }

    input = getCleanedNumber(input);

    if (input.length != 16) {
      return 'Card is invalid';
    }

    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int _convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool _hasDateExpired(int month, int year) {
    // It has not expired if both the year and date has not passed
    return !_hasYearPassed(year) && !_hasMonthPassed(year, month);
  }

  static List<String> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [split[0], split[1]];
  }

  static bool _hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return _hasYearPassed(year) ||
        _convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool _hasYearPassed(int year) {
    int fourDigitsYear = _convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static String getCleanedNumber(String text) {
    // RegExp regExp = RegExp(r'[^0-9]');
    return text.replaceAll(' ', '');
  }
}
