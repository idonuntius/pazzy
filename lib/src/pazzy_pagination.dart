import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/// This model defines pagination information.
@immutable
class PazzyPagination {
  /// This model defines pagination information.
  const PazzyPagination({
    required this.current,
    required this.previous,
    required this.next,
    required this.numbers,
  });

  /// The current page.
  final int current;

  /// The page before the current page. If it is not possible to go back,
  /// `null` is used.
  final int? previous;

  /// The next page after the current page.
  /// This will be `null` if you cannot go to the next page.
  final int? next;

  /// An array of numbers used for pagination.
  /// Omitted parts are filled with `null`.
  final List<int?> numbers;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PazzyPagination &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.previous, previous) || other.previous == previous) &&
            (identical(other.next, next) || other.next == next) &&
            const DeepCollectionEquality().equals(other.numbers, numbers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, current, previous, next, numbers);

  @override
  String toString() {
    return 'PazzyPagination(current: $current, previous: $previous, next: $next, numbers: $numbers)';
  }
}
