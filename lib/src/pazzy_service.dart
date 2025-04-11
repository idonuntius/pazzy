import 'dart:math';

import 'package:pazzy/src/extension/int_extension.dart';
import 'package:pazzy/src/pazzy_pagination.dart';

/// [PazzyService] performs pagination processing.
final class PazzyService {
  /// [PazzyService] performs pagination processing.
  const PazzyService({
    required this.itemCount,
    required this.currentPage,
    required this.perPage,
  });

  /// Item count.
  final int itemCount;

  /// The current page.
  final int currentPage;

  /// Number of page items to display.
  final int perPage;

  /// Create items to display on the current page.
  List<int> createDisplayIndexList() {
    final indexList = List.generate(itemCount, (number) => number);
    final offset = (currentPage - 1) * perPage + 1;
    if (offset == 0 && perPage < itemCount) {
      return indexList;
    }

    final fromIndex = offset - 1;
    if (itemCount <= fromIndex) {
      return [];
    }

    final toIndex = itemCount.coerceAtMost(fromIndex + perPage);
    return indexList.sublist(fromIndex, toIndex);
  }

  /// Create the necessary values for pagination display.
  ///
  /// [PazzyPagination] Model Description
  /// * `current`: The current page.
  /// * `previous`: The page before the current page.
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
  PazzyPagination createPazzyPagination() {
    final lastPage = (itemCount.toDouble() / perPage).ceil().coerceAtLeast(1);
    final prev = currentPage <= 1 || currentPage > lastPage ? null : currentPage - 1;
    final next = currentPage >= lastPage ? null : currentPage + 1;
    final numbers = <int?>[1];

    if (currentPage == 1 && lastPage == 1) {
      return PazzyPagination(
        current: currentPage,
        previous: prev,
        next: next,
        totalNumberOfPages: lastPage,
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
    final rangeStart = min(currentPage, lastPage) - rangeSize;
    final rangeEnd = min(currentPage, lastPage) + rangeSize;

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
      totalNumberOfPages: lastPage,
      numbers: numbers,
    );
  }
}
