/// Class of validation functions that the app will use
///   - This class should be used as a mixin using the `with` keyword
class Validators {
  final phoneNumberRegExp = RegExp(
      r'^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$');
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final zipCodeRegExp = RegExp(r'^[0-9]{5}(?:-[0-9]{4})?$');

  String validateEmail(String value) {
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
  }

  /// Phone numbers are expected to be in the form xxx-xxx-xxxx
  String validatePhoneNumber(String value) {
    if (!phoneNumberRegExp.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  String validateZip(String value) {
    if (!zipCodeRegExp.hasMatch(value)) {
      return 'Invalid zip code';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'Password is required';
    } else if (value.length <= 6) {
      return 'Password should be more than 6 characters';
    }
    return null;
  }
}
