bool isValidPhoneNumber(String? string) {
  if (string == null || string.isEmpty) {
    return false;
  }

  const pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

bool validateCardOwner(String input) {
  if (input.isEmpty) {
    return false;
  }
  if (input.contains(RegExp(r'[a-zA-Z]+'))) {
    // TODO: Este validador puede mejorar
    return true;
  } else {
    return false;
  }
}

bool isValidEmail(String? string) {
  if (string == null || string.isEmpty) {
    return false;
  }

  const pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

bool isValidName(String input) {
  if (input.isEmpty) {
    return false;
  }
  return !RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(input);
}

bool isValidAddress(String input) {
  if (input.isEmpty) {
    return false;
  }
  return !RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(input);
}

bool isValidDni(String input) {
  if (input.isEmpty) {
    return false;
  }
  return !RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%a-zA-Z-]').hasMatch(input) &&
      (input.length <= 9);
}

bool validateSecurityCode(String input) {
  if (input.length != 3) {
    return false;
  } else {
    return true;
  }
}

bool validateCardNumWithLuhnAlgorithm(String input) {
  if (input.isEmpty) {
    return false;
  }

  if (input.length < 8) {
    return false;
  }

  int sum = 0;
  int length = input.length;
  for (var i = 0; i < length; i++) {
    int digit = int.parse(input[length - i - 1]);
    if (i % 2 == 1) {
      digit *= 2;
    }
    sum += digit > 9 ? (digit - 9) : digit;
  }

  if (sum % 10 == 0) {
    return true;
  }

  return false;
}

bool validateDate(String value) {
  if (value.isEmpty) {
    return false;
  }

  int year;
  int month;
  if (value.contains(RegExp(r'(\/)'))) {
    var split = value.split(RegExp(r'(\/)'));
    month = int.parse(split[0]);
    year = int.parse(split[1]);
  } else {
    month = int.parse(value.substring(0, (value.length)));
    year = -1;
  }

  if ((month < 1) || (month > 12)) {
    return false;
  }

  var fourDigitsYear = convertYearTo4Digits(year);
  if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
    return false;
  }

  if (!hasDateExpired(month, year)) {
    return false;
  }
  return true;
}

int convertYearTo4Digits(int year) {
  if (year < 100 && year >= 0) {
    var now = DateTime.now();
    String currentYear = now.year.toString();
    String prefix = currentYear.substring(0, currentYear.length - 2);
    year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
  }
  return year;
}

bool hasDateExpired(int? month, int? year) {
  return !(month == null || year == null) && isNotExpired(year, month);
}

bool isNotExpired(int year, int month) {
  return !hasYearPassed(year) && !hasMonthPassed(year, month);
}

bool hasMonthPassed(int year, int month) {
  var now = DateTime.now();
  return hasYearPassed(year) ||
      convertYearTo4Digits(year) == now.year && (month < now.month + 1);
}

bool hasYearPassed(int year) {
  int fourDigitsYear = convertYearTo4Digits(year);
  var now = DateTime.now();
  return fourDigitsYear < now.year;
}
