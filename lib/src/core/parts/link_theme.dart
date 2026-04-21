import 'package:flutter/widgets.dart';

@immutable
class LinkTheme {
  const LinkTheme({this.stroke, this.strokeWidth});

  final Color? stroke;
  final double? strokeWidth;

  LinkTheme copyWith({Color? fill, Color? stroke, double? strokeWidth}) {
    return LinkTheme(
      stroke: stroke ?? this.stroke,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}
