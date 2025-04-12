import 'package:flutter/foundation.dart';
import 'package:pazzy/src/extension/list_extension.dart';

/// This model defines pagination information.
@immutable
class PazzyPagination {
  /// This model defines pagination information.
  const PazzyPagination({
    required this.current,
    required this.previous,
    required this.next,
    required this.totalNumberOfPages,
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

  /// Total number of pages.
  final int totalNumberOfPages;

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
            (identical(other.totalNumberOfPages, totalNumberOfPages) ||
                other.totalNumberOfPages == totalNumberOfPages) &&
            other.numbers.equals(numbers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, current, previous, next, totalNumberOfPages, numbers);

  @override
  String toString() {
    return 'PazzyPagination(current: $current, previous: $previous, next: $next, totalNumberOfPages: $totalNumberOfPages, numbers: $numbers)';
  }
}
