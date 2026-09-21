import 'package:flutter/widgets.dart';

/// How the link should look when painted on the screen.
///
/// Allows for setting a [stroke] color and [strokeWidth].
@immutable
class LinkTheme {
  /// Default implementation.
  const LinkTheme({this.stroke, this.strokeWidth});

  /// The color the link should be.
  final Color? stroke;

  /// The thickness of the link line.
  final double? strokeWidth;

  /// Copy this link with new properties.
  LinkTheme copyWith({Color? stroke, double? strokeWidth}) {
    return LinkTheme(
      stroke: stroke ?? this.stroke,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}
