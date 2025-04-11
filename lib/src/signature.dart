import 'package:flutter/material.dart';

/// Signature for a function that creates a widget for a given index.
typedef PazzyItemBuilder = Widget Function(BuildContext context, int index);

/// Signature for a function that creates a widget for a given number.
typedef PazzyNumberBuilder = Widget Function(
  BuildContext context,
  int? number,
  bool current,
);

/// Signature for a function that creates the previous Button widget.
typedef PazzyPreviousButtonBuilder = Widget Function(
  BuildContext context,
  int? previousPage,
);

/// Signature for a function that creates the next Button widget.
typedef PazzyNextButtonBuilder = Widget Function(
  BuildContext context,
  int? nextPage,
);

/// Signature for a function that creates the pagination text widget.
typedef PazzyPaginationTextBuilder = Widget Function(
  BuildContext context,
  int current,
  int totalNumberOfPages,
);
