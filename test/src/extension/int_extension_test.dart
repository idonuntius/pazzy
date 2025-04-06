import 'package:flutter_test/flutter_test.dart';
import 'package:pazzy/src/extension/int_extension.dart';

void main() {
  group('IntExtension', () {
    group('coerceAtMost', () {
      for (final (target, maximumValue, expected) in <(int, int, int)>[
        (0, 0, 0),
        (1, 0, 0),
        (0, 1, 0),
        (5, 10, 5),
        (10, 5, 5),
      ]) {
        test('when target is $target and maximum is $maximumValue - should be $expected', () {
          final actual = target.coerceAtMost(maximumValue);
          expect(actual, expected);
        });
      }
    });

    group('coerceAtLeast', () {
      for (final (target, minimumValue, expected) in <(int, int, int)>[
        (0, 0, 0),
        (1, 0, 1),
        (0, 1, 1),
        (5, 10, 10),
        (10, 5, 10),
      ]) {
        test('when target is $target and minimum is $minimumValue - should be $expected', () {
          final actual = target.coerceAtLeast(minimumValue);
          expect(actual, expected);
        });
      }
    });
  });
}
