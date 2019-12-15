import 'package:flutter_test/flutter_test.dart';
import 'package:provider_start/core/mixins/validators.dart';

void main() {
  Validators validators;

  setUp(() {
    validators = Validators();
  });

  group('email validator', () {
    test('should return null when email is valid', () {
      final result = validators.validateEmail('example@gmail.com');
      expect(result, null);
    });

    test('should return null when email is valid with whitespace', () {
      final result = validators.validateEmail('  example@gmail.com  ');
      expect(result, null);
    });

    test('should return error message when email is missing @', () {
      final result = validators.validateEmail('examplegmail.com');
      expect(result.runtimeType, String);
    });

    test('should return error message when email is missing @ prefix', () {
      final result = validators.validateEmail('@gmail.com');
      expect(result.runtimeType, String);
    });
  });

  group('zip code validator', () {
    test('should return null when zip code is valid', () {
      final cupertinoZipCode = '95014';
      final result = validators.validateZip(cupertinoZipCode);
      expect(result, null);
    });

    test('should return null when full zip code is valid', () {
      final cupertinoZipCode = '95014-1234';
      final result = validators.validateZip(cupertinoZipCode);
      expect(result, null);
    });

    test('should return null when zip code is valid with whitespace', () {
      final cupertinoZipCode = '  95014  ';
      final result = validators.validateZip(cupertinoZipCode);
      expect(result, null);
    });

    test('should return error message when full zip code is invalid length',
        () {
      final cupertinoZipCode = '9501';
      final result = validators.validateZip(cupertinoZipCode);
      expect(result.runtimeType, String);
    });
  });

  group('phone number validator', () {
    test('should return null when phone number is valid', () {
      final result = validators.validatePhoneNumber('1112223333');
      expect(result, null);
    });

    test('should return null when phone number is valid', () {
      final result = validators.validatePhoneNumber('(111) 222-3333');
      expect(result, null);
    });

    test('should return null when phone number is valid with whitespace', () {
      final result = validators.validatePhoneNumber('  1112223333  ');
      expect(result, null);
    });

    test('should return error message when phone number is invalid length', () {
      final result = validators.validatePhoneNumber('(1111) 222-3333');
      expect(result.runtimeType, String);
    });

    test('should return error message when phone number is invalid length', () {
      final result = validators.validatePhoneNumber('111222333333333');
      expect(result.runtimeType, String);
    });
  });
}
