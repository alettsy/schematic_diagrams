import 'package:flutter/material.dart';

/// How the text block should look when painted on the screen.
@immutable
class TextBlockTheme {
  /// Create a new [TextBlockTheme] with an optional [color],
  /// [fontSize], [fontWeight], and [fontFamily].
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TextBlockTheme) return false;

    return color == other.color &&
        fontSize == other.fontSize &&
        fontFamily == other.fontFamily &&
        fontWeight == other.fontWeight;
  }

  @override
  int get hashCode => Object.hash(color, fontSize, fontFamily, fontWeight);
}
