import 'package:flutter/cupertino.dart';
import 'package:schematic_diagrams/src/core/parts/position.dart';
import 'package:schematic_diagrams/src/core/parts/text_block_theme.dart';

class TextBlock {
  TextBlock({
    required this.text,
    this.id,
    this.position = const Position(0, 0),
    this.drawWidth = 100,
    this.themeOverride = const TextBlockTheme(),
    this.textAlign = TextAlign.start,
  });

  final String? id;
  final String text;
  final Position position;
  final double drawWidth;
  final TextBlockTheme themeOverride;
  final TextAlign textAlign;

  TextBlock copyWith({
    String? id,
    String? text,
    Position? position,
    double? drawWidth,
    TextBlockTheme? themeOverride,
    TextAlign? textAlign,
  }) {
    return TextBlock(
      id: id ?? this.id,
      text: text ?? this.text,
      position: position ?? this.position,
      drawWidth: drawWidth ?? this.drawWidth,
      themeOverride: themeOverride ?? this.themeOverride,
      textAlign: textAlign ?? this.textAlign,
    );
  }
}
