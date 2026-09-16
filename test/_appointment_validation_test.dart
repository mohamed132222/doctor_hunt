import 'package:doctor_hunt/apps/core/validators/app_validators.dart';
import 'package:flutter_test/flutter_test.dart';

/// Regression guard: the appointment form once returned its "required" message
/// for *every* input because the validator ignored its `value` argument.
void main() {
  group('personName', () {
    test('accepts the values a real user types', () {
      expect(AppValidators.personName('mohamed'), isNull);
      expect(AppValidators.personName('Mohamed'), isNull);
      expect(AppValidators.personName('Mohamed Ali'), isNull);
      expect(AppValidators.personName("O'Brien"), isNull);
      expect(AppValidators.personName('Anne-Marie'), isNull);
      expect(AppValidators.personName('محمد'), isNull);
      expect(AppValidators.personName('  mohamed  '), isNull);
    });

    test('rejects empty, too short and non-letter input', () {
      expect(AppValidators.personName(''), isNotNull);
      expect(AppValidators.personName('   '), isNotNull);
      expect(AppValidators.personName(null), isNotNull);
      expect(AppValidators.personName('ab'), isNotNull);
      expect(AppValidators.personName('mohamed123'), isNotNull);
      expect(AppValidators.personName('12345'), isNotNull);
    });
  });

  group('phone', () {
    test('accepts the values a real user types', () {
      expect(AppValidators.phone('2001204435482'), isNull);
      expect(AppValidators.phone('+20 100 123 4567'), isNull);
      expect(AppValidators.phone('01001234567'), isNull);
      expect(AppValidators.phone('(020) 1234-5678'), isNull);
    });

    test('rejects empty, too short and non-numeric input', () {
      expect(AppValidators.phone(''), isNotNull);
      expect(AppValidators.phone(null), isNotNull);
      expect(AppValidators.phone('123'), isNotNull);
      expect(AppValidators.phone('abcdefgh'), isNotNull);
      expect(AppValidators.phone('1234567890123456789'), isNotNull);
    });
  });
}
