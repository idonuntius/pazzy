import 'package:flutter/material.dart';
import 'package:pazzy/src/pazzy_service.dart';
import 'package:pazzy/src/signature.dart';

/// Widget that displays Items and pagination without numbered buttons.
class PazzyNumberlessWidget extends StatelessWidget {
  /// Widget that displays Items and pagination without numbered buttons.
  const PazzyNumberlessWidget({
    required this.itemCount,
    required this.currentPage,
    required this.perPage,
    required this.itemBuilder,
    required this.previousButtonBuilder,
    required this.nextButtonBuilder,
    this.paginationTextBuilder,
    this.itemsAndPaginationSpacing = 0,
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

  /// A function that creates the pagination text widget.
  /// `current` is the current page and `totalNumberOfPages` is the total number of pages.
  final PazzyPaginationTextBuilder? paginationTextBuilder;

  /// Spacing between items and pagination.
  final double itemsAndPaginationSpacing;

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              previousButtonBuilder(context, pagination.previous),
              if (paginationTextBuilder != null)
                paginationTextBuilder!(context, currentPage, pagination.totalNumberOfPages),
              nextButtonBuilder(context, pagination.next),
            ],
          ),
        ),
      ],
    );
  }
}
