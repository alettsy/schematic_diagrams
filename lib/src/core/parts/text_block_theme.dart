import 'package:flutter/material.dart';

@immutable
class TextBlockTheme {
  const TextBlockTheme({
    this.color = Colors.black,
    this.fontSize = 12,
    this.fontWeight = FontWeight.normal,
    this.fontFamily,
  });

  final Color? color;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;

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
