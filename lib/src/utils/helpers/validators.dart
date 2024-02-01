class Validator {
  Validator._();

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  static bool isValidEmail(String email) {
    const emailRegExpString = r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9]'
        r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
    return RegExp(emailRegExpString, caseSensitive: false).hasMatch(email);
  }

  static bool isURL(String url) {
    const regexUrl =
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    return RegExp(regexUrl).hasMatch(url);
  }

  static bool isValidUserName(String userName) {
    return userName.length >= 3;
  }

  static bool isValidPhoneNumber(String phone) {
    final regexPhone = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

    return (phone.length > 9 && phone.length < 15) &&
        regexPhone.hasMatch(phone);
  }

  static bool isValidOTP(String token) {
    final regexPhone = RegExp(r'^[0-9]+$');

    return token.length == 6 && regexPhone.hasMatch(token);
  }

  static bool validateCurrentDateBetweenStartAndEndDate(
      DateTime startDate, DateTime endDate) {
    DateTime today = DateTime.now();

    if (today.isAfter(startDate) && today.isBefore(endDate)) {
      return true;
    } else {
      return false;
    }
  }
}
