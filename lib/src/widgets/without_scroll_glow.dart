import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class without_scroll_glow extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
