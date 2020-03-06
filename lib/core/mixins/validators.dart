import 'package:provider_start/core/constant/validator_keys.dart';

/// Class of validation functions that the app will use
///   - This class should be used as a mixin using the `with` keyword
class Validators {
  final phoneNumberRegExp = RegExp(
      r'^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$');
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final zipCodeRegExp = RegExp(r'^[0-9]{5}(?:-[0-9]{4})?$');

  String validateEmail(String value) {
    if (!emailRegExp.hasMatch(value.trim())) {
      return ValidatorKeys.invalid_email;
    }
    return null;
  }

  String validatePhoneNumber(String value) {
    if (!phoneNumberRegExp.hasMatch(value.trim())) {
      return ValidatorKeys.invalid_phone_number;
    }
    return null;
  }

  String validateZip(String value) {
    if (!zipCodeRegExp.hasMatch(value.trim())) {
      return ValidatorKeys.invalid_zip_code;
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty) {
      return ValidatorKeys.password_empty;
    } else if (value.length <= 6) {
      return ValidatorKeys.password_short;
    }
    return null;
  }
}
