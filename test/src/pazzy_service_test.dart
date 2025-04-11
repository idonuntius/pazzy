import 'package:flutter_test/flutter_test.dart';
import 'package:pazzy/src/pazzy_pagination.dart';
import 'package:pazzy/src/pazzy_service.dart';

void main() {
  group('PazzyService', () {
    const perPage = 10;

    group('#createDisplayIndexList', () {
      for (final (items, currentPage, expected) in [
        (<int>[], 1, <int>[]),
        (<int>[0, 1, 2], 1, <int>[0, 1, 2]),
        (<int>[0, 1, 2], 2, <int>[]),
        (List.generate(13, (number) => number), 1, List.generate(10, (number) => number)),
        (List.generate(13, (number) => number), 2, <int>[10, 11, 12]),
        (List.generate(45, (number) => number), 3, <int>[20, 21, 22, 23, 24, 25, 26, 27, 28, 29]),
        (List.generate(45, (number) => number), 5, <int>[40, 41, 42, 43, 44]),
        (List.generate(45, (number) => number), 6, <int>[]),
      ]) {
        test('when items length is ${items.length} and currentPage is $currentPage - should be $expected', () {
          final service = PazzyService(itemCount: items.length, currentPage: currentPage, perPage: perPage);
          final actual = service.createDisplayIndexList();
          expect(actual, expected);
        });
      }
    });

    group('#createPazzyPagination', () {
      for (final (items, currentPage, expected) in [
        (
          <int>[],
          1,
          const PazzyPagination(current: 1, previous: null, next: null, totalNumberOfPages: 1, numbers: [1])
        ),
        (
          <int>[0, 1, 2],
          1,
          const PazzyPagination(current: 1, previous: null, next: null, totalNumberOfPages: 1, numbers: [1])
        ),
        (
          <int>[0, 1, 2],
          2,
          const PazzyPagination(current: 2, previous: null, next: null, totalNumberOfPages: 1, numbers: [1])
        ),
        (
          <int>[0, 1, 2],
          3,
          const PazzyPagination(current: 3, previous: null, next: null, totalNumberOfPages: 1, numbers: [1])
        ),
        (
          List.generate(13, (number) => number),
          1,
          const PazzyPagination(current: 1, previous: null, next: 2, totalNumberOfPages: 2, numbers: [1, 2])
        ),
        (
          List.generate(13, (number) => number),
          2,
          const PazzyPagination(current: 2, previous: 1, next: null, totalNumberOfPages: 2, numbers: [1, 2])
        ),
        (
          List.generate(45, (number) => number),
          3,
          const PazzyPagination(current: 3, previous: 2, next: 4, totalNumberOfPages: 5, numbers: [1, 2, 3, 4, 5])
        ),
        (
          List.generate(45, (number) => number),
          5,
          const PazzyPagination(current: 5, previous: 4, next: null, totalNumberOfPages: 5, numbers: [1, null, 3, 4, 5])
        ),
        (
          List.generate(45, (number) => number),
          8,
          const PazzyPagination(
            current: 8,
            previous: null,
            next: null,
            totalNumberOfPages: 5,
            numbers: [1, null, 3, 4, 5],
          )
        ),
        (
          List.generate(55, (number) => number),
          5,
          const PazzyPagination(current: 5, previous: 4, next: 6, totalNumberOfPages: 6, numbers: [1, null, 3, 4, 5, 6])
        ),
        (
          List.generate(66, (number) => number),
          5,
          const PazzyPagination(
            current: 5,
            previous: 4,
            next: 6,
            totalNumberOfPages: 7,
            numbers: [1, null, 3, 4, 5, 6, 7],
          )
        ),
        (
          List.generate(77, (number) => number),
          5,
          const PazzyPagination(
            current: 5,
            previous: 4,
            next: 6,
            totalNumberOfPages: 8,
            numbers: [1, null, 3, 4, 5, 6, 7, 8],
          )
        ),
        (
          List.generate(88, (number) => number),
          5,
          const PazzyPagination(
            current: 5,
            previous: 4,
            next: 6,
            totalNumberOfPages: 9,
            numbers: [1, null, 3, 4, 5, 6, 7, null, 9],
          )
        ),
        (
          List.generate(99, (number) => number),
          5,
          const PazzyPagination(
            current: 5,
            previous: 4,
            next: 6,
            totalNumberOfPages: 10,
            numbers: [1, null, 3, 4, 5, 6, 7, null, 10],
          )
        ),
      ]) {
        test('when items length is ${items.length} and currentPage is $currentPage - should be $expected', () {
          final service = PazzyService(itemCount: items.length, currentPage: currentPage, perPage: perPage);
          final actual = service.createPazzyPagination();
          expect(actual, expected);
        });
      }
    });
  });
}
