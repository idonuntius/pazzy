extension IntExtension on int {
  int coerceAtMost(int maximumValue) {
    return this > maximumValue ? maximumValue : this;
  }
}
