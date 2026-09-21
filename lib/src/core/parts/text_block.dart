import 'package:flutter/cupertino.dart';
import 'package:schematic_diagrams/src/core/parts/position.dart';
import 'package:schematic_diagrams/src/core/parts/text_block_theme.dart';

/// A block of text that a node can render as part of itself.
class TextBlock {
  /// Default implementation.
  TextBlock({
    required this.text,
    this.id,
    this.position = const Position(0, 0),
    this.drawWidth = 100,
    this.themeOverride = const TextBlockTheme(),
    this.textAlign = TextAlign.start,
  });

  /// The unique [id] of this text block.
  final String? id;

  /// The textual content.
  final String text;

  /// The position of this text block, relative to the parent node.
  final Position position;

  /// How much horizontal space it should take up.
  final double drawWidth;

  /// The theme that takes precedence over the inherited theme.
  final TextBlockTheme themeOverride;

  /// Text alignment inside the available space.
  final TextAlign textAlign;

  /// Copy this text block with new properties.
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
