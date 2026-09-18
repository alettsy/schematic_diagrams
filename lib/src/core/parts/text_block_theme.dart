import 'package:flutter/material.dart';

/// How the text block should look when painted on the screen.
@immutable
class TextBlockTheme {
  /// Default implementation.
  const TextBlockTheme({
    this.color = Colors.black,
    this.fontSize = 12,
    this.fontWeight = FontWeight.normal,
    this.fontFamily,
  });

  /// The color of the text.
  final Color? color;

  /// The font family to use.
  final String? fontFamily;

  /// The font size.
  final double? fontSize;

  /// The font weight.
  final FontWeight? fontWeight;

  /// Copy this text block theme with new properties.
  TextBlockTheme copyWith({
    Color? color,
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
  }) {
    return TextBlockTheme(
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      fontWeight: fontWeight ?? this.fontWeight,
    );
  }
}
