import 'dart:math';

extension IntExtension on int {
  /// Forces the value to be less than or equal to the specified upper limit.
  int coerceAtMost(int maximumValue) => min(this, maximumValue);

  /// Forces the value to be greater than or equal to the specified lower limit.
  int coerceAtLeast(int minimumValue) => max(this, minimumValue);
}
