/// Extension of List
extension ListExtension<T> on List<T> {
  /// Compare two elements for being equal.
  bool equals(List<T> other) {
    if (identical(this, other)) return true;
    if (length != other.length) return false;
    final indexList = List.generate(length, (index) => index);
    return indexList.every((index) => this[index] == other[index]);
  }
}
