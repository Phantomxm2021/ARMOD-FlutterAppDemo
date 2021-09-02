import 'package:flutter/cupertino.dart';

class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final int itemCount;

  ///Method to manually trigger focus to an item. Call with help of `GlobalKey<ScrollSnapListState>`.
  final void Function(int)? focusToItem;
  static BuildContext? buildContext;

  const ColumnBuilder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    required this.focusToItem,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection: VerticalDirection.down,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return new Column(
      children: new List.generate(this.itemCount, _buildListItem).toList(),
    );
  }

  Widget _buildListItem(int index) {
    Widget child;
    child = this.itemBuilder(buildContext!, index);

    return GestureDetector(
      onTap: () => focusToItem!(index),
      child: child,
    );
  }
}
