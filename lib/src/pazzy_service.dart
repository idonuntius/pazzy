import 'dart:math';

import 'package:pazzy/src/extension/int_extension.dart';
import 'package:pazzy/src/pazzy_pagination.dart';

/// [PazzyService] performs pagination processing.
final class PazzyService<T> {
  /// Constructor of [PazzyService]
  const PazzyService({required this.items, required this.perPage});

  /// List of items to be paginated.
  final List<T> items;

  /// Number of page items to display.
  final int perPage;

  /// Items size
  int get _itemLength => items.length;

  /// Create items to display on the current page.
  List<T> createSeparatedItems(int currentPage) {
    final offset = (currentPage - 1) * perPage + 1;
    if (offset == 0 && perPage < _itemLength) {
      return items;
    }

    final fromIndex = offset - 1;
    if (_itemLength <= fromIndex) {
      return [];
    }

    final toIndex = _itemLength.coerceAtMost(fromIndex + _itemLength);
    return items.sublist(fromIndex, toIndex);
  }

  /// Create the necessary values for pagination display.
  ///
  /// [PazzyPagination] Model Description
  /// * `current`: The current page.
  /// * `prev`: The page before the current page.
  ///           If it is not possible to go back, `null` is used.
  /// * `next`: The next page after the current page.
  /// .         This will be `null` if you cannot go to the next page.
  /// * `items`: An array of numbers used for pagination.
  /// .          Omitted parts are filled with `null`.
  ///
  /// The algorithm is implemented based on the following
  /// https://www.zacfukuda.com/blog/pagination-algorithm
  ///
  /// SAMPLE)
  ///
  /// lastPage: 1
  ///   current:1 ===>
  ///     (previous: null, next: null, numbers: [1])
  ///
  /// lastPage: 3
  ///   current:1 ===>
  ///     (previous: null, next: 2, numbers: [1, 2, 3])
  ///   current:2 ===>
  ///     (previous: 1, next: 3, numbers: [1, 2, 3])
  ///   current:3 ===>
  ///     (previous: 2, next: null, numbers: [1, 2, 3])
  ///
  /// lastPage: 5
  ///   current:1 ===>
  ///     (previous: null, next: 2, numbers: [1, 2, 3, null, 5])
  ///   current:2 ===>
  ///     (previous: 1, next: 3, numbers: [1, 2, 3, 4, 5])
  ///   current:3 ===>
  ///     (previous: 2, next: 4, numbers: [1, 2, 3, 4, 5])
  ///   current:4 ===>
  ///     (previous: 3, next: 5, numbers: [1, 2, 3, 4, 5])
  ///   current:5 ===>
  ///     (previous: 4, next: null, numbers: [1, null, 3, 4, 5])
  ///
  /// lastPage: 7
  ///   current:1 ===>
  ///     (previous: null, next: 2, numbers: [1, 2, 3, null, 7])
  ///   current:2 ===>
  ///     (previous: 1, next: 3, numbers: [1, 2, 3, 4, null, 7])
  ///   current:3 ===>
  ///     (previous: 2, next: 4, numbers: [1, 2, 3, 4, 5, null, 7])
  ///   current:4 ===>
  ///     (previous: 3, next: 5, numbers: [1, 2, 3, 4, 5, 6, 7])
  ///   current:5 ===>
  ///     (previous: 4, next: 6, numbers: [1, null, 3, 4, 5, 6, 7])
  ///   current:6 ===>
  ///     (previous: 5, next: 7, numbers: [1, null, 4, 5, 6, 7])
  ///   current:7 ===>
  ///     (previous: 6, next: null, numbers: [1, null, 5, 6, 7])
  ///
  /// lastPage: 9
  ///   current:1 ===>
  ///     (previous: null, next: 2, numbers: [1, 2, 3, null, 9])
  ///   current:2 ===>
  ///     (previous: 1, next: 3, numbers: [1, 2, 3, 4, null, 9])
  ///   current:3 ===>
  ///     (previous: 2, next: 4, numbers: [1, 2, 3, 4, 5, null, 9])
  ///   current:4 ===>
  ///     (previous: 3, next: 5, numbers: [1, 2, 3, 4, 5, 6, null, 9])
  ///   current:5 ===>
  ///     (previous: 4, next: 6, numbers: [1, null, 3, 4, 5, 6, 7, null, 9])
  ///   current:6 ===>
  ///     (previous: 5, next: 7, numbers: [1, null, 4, 5, 6, 7, 8, 9])
  ///   current:7 ===>
  ///     (previous: 6, next: 8, numbers: [1, null, 5, 6, 7, 8, 9])
  ///   current:8 ===>
  ///     (previous: 7, next: 9, numbers: [1, null, 6, 7, 8, 9])
  ///   current:9 ===>
  ///     (previous: 8, next: null, numbers: [1, null, 7, 8, 9])
  PazzyPagination createPazzyNumbers(int currentPage) {
    final lastPage = (_itemLength.toDouble() / perPage).ceil();
    final prev = currentPage == 1 ? null : currentPage - 1;
    final next = currentPage == lastPage ? null : currentPage + 1;
    final numbers = <int?>[1];

    if (currentPage == 1 && lastPage == 1) {
      return PazzyPagination(
        current: currentPage,
        previous: prev,
        next: next,
        numbers: numbers,
      );
    }
    if (currentPage > 4) {
      numbers.add(null);
    }

    // The rangeSize is the number of pages to be shown
    // on each side of the current page.
    //                  ┌─ rangeSize ─┓┌─ rangeSize ──┓
    //                  │             ││              │
    //             rangeStart      current         rangeEnd
    // 1      null      8      9      10      11      12      null      20
    const rangeSize = 2;
    final rangeStart = currentPage - rangeSize;
    final rangeEnd = currentPage + rangeSize;

    for (var i = max(rangeStart, 2); i <= min(lastPage, rangeEnd); i++) {
      numbers.add(i);
    }

    if (rangeEnd + 1 < lastPage) {
      numbers.add(null);
    }
    if (rangeEnd < lastPage) {
      numbers.add(lastPage);
    }

    return PazzyPagination(
      current: currentPage,
      previous: prev,
      next: next,
      numbers: numbers,
    );
  }
}
