/// This model defines pagination information.
class PazzyPagination {
  const PazzyPagination({required this.current, required this.previous, required this.next, required this.numbers});

  /// The current page.
  final int current;

  /// The page before the current page. If it is not possible to go back, `null` is used.
  final int? previous;

  /// The next page after the current page. This will be `null` if you cannot go to the next page.
  final int? next;

  /// An array of numbers used for pagination. Omitted parts are filled with `null`.
  final List<int?> numbers;

  @override
  String toString() => 'PazzyNumbers(current: $current, previous: $previous, next: $next, numbers: $numbers)';
}
