extension IntExtension on int {
  int coerceAtMost(int maximumValue) => this > maximumValue ? maximumValue : this;
}
