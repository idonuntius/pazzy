import 'package:flutter/material.dart';
import 'package:pazzy/src/pazzy_service.dart';
import 'package:pazzy/src/signature.dart';

/// Widget that displays Items and pagination with numbered buttons.
class PazzyWidget extends StatelessWidget {
  /// Widget that displays Items and pagination with numbered buttons.
  const PazzyWidget({
    required this.itemCount,
    required this.currentPage,
    required this.perPage,
    required this.itemBuilder,
    required this.numberBuilder,
    required this.previousButtonBuilder,
    required this.nextButtonBuilder,
    this.itemsAndPaginationSpacing = 0,
    this.numberButtonSpacing = 0,
    this.paginationHeight = 44,
    super.key,
  })  : assert(currentPage > 0, 'currentPage must be greater than zero.'),
        assert(perPage > 0, 'perPage must be greater than zero.');

  /// Item count.
  final int itemCount;

  /// Currently displayed page number
  final int currentPage;

  /// Number of page items to display.
  final int perPage;

  /// A function that creates a widget for a given index.
  /// A `index` returns the index of the item list calculated based on `itemCount`.
  final PazzyItemBuilder itemBuilder;

  /// A function that creates a widget for a given number.
  /// If the given `currentPage` and `number` have the same value, `current` is `true`.
  final PazzyNumberBuilder numberBuilder;

  /// A function that creates the previous Button widget.
  /// The `previousPage` is numbered if it is possible to go back to
  /// the previous page from the `currentPage`,
  /// or null if it is not possible to go back to the previous page.
  final PazzyPreviousButtonBuilder previousButtonBuilder;

  /// A function that creates the next Button widget.
  /// The `nextPage` is numbered if it is possible to go from
  /// the current page to the `nextPage`,
  /// or null if it is impossible to go to the next page.
  final PazzyNextButtonBuilder nextButtonBuilder;

  /// Spacing between items and pagination.
  final double itemsAndPaginationSpacing;

  /// Spacing between number buttons.
  final double numberButtonSpacing;

  /// Hight of pagination widget.
  final double paginationHeight;

  @override
  Widget build(BuildContext context) {
    final pazzyService = PazzyService(
      itemCount: itemCount,
      currentPage: currentPage,
      perPage: perPage,
    );
    final displayItemIndexList = pazzyService.createDisplayIndexList();
    final pagination = pazzyService.createPazzyPagination();

    return Column(
      spacing: itemsAndPaginationSpacing,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: displayItemIndexList.length,
          itemBuilder: (context, index) => itemBuilder(
            context,
            displayItemIndexList[index],
          ),
        ),
        SizedBox(
          height: paginationHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // previous button + numbers buttons + next button
            itemCount: 1 + pagination.numbers.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return previousButtonBuilder(
                  context,
                  pagination.previous,
                );
              } else if (index == pagination.numbers.length + 1) {
                return nextButtonBuilder(context, pagination.next);
              } else {
                final number = pagination.numbers[index - 1];
                return numberBuilder(
                  context,
                  number,
                  number == currentPage,
                );
              }
            },
            separatorBuilder: (_, __) {
              return SizedBox(width: numberButtonSpacing);
            },
          ),
        ),
      ],
    );
  }
}
