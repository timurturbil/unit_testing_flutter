
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/UI/view/LoginPage.dart';
void main() {  
  group('Validator', () {
    test('Empty Email Test', () {
      var validator = Validator.validateEmail('');
      expect(validator, 'Email can\'t be empty');
    });
    test('Email doesn\'t contain @ test', () {
      var validator = Validator.validateEmail('timur.gmail.com');
      expect(validator, "Email need to be contain @ expression");
    });
    test('Valid Email Test', () {
      var validator = Validator.validateEmail('timur@gmail.com');
      expect(validator, null);
    });
    test('Empty Password Test', () {
      var validator = Validator.validatePassword('');
      expect(validator, 'Password can\'t be empty');
    });
    test('Length of Password Test', () {
      var validator = Validator.validatePassword("hey");
      expect(validator, "Password characther need to be more than 6");
    });
    test('Valid Password Test', () {
      var validator = Validator.validatePassword('12345678');
      expect(validator, null);
    });
  });
}
