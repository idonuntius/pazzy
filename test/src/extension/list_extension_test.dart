import 'package:flutter_test/flutter_test.dart';
import 'package:pazzy/src/extension/list_extension.dart';

void main() {
  group('ListExtension', () {
    group('#equals', () {
      test('when both lists are empty - should be true', () {
        final target = <int>[];
        final other = <int>[];
        expect(target.equals(other), isTrue);
      });

      test('when both lists are identical - should be true', () {
        final target = [0, 1, null];
        expect(target.equals(target), isTrue);
      });

      test('when both lists are the same value - should be true', () {
        final target = [0, 1, null];
        final other = [0, 1, null];
        expect(target.equals(other), isTrue);
      });

      test('when both lists are of different lengths - should be false', () {
        final target = [0, 1, null];
        final other = [0, 1];
        expect(target.equals(other), isFalse);
      });

      test('when both lists are different values - should be false', () {
        final target = [0, 1, null];
        final other = [0, 1, 2];
        expect(target.equals(other), isFalse);
      });
    });
  });
}
