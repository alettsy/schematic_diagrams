import 'package:flutter/material.dart';
import 'package:schematic_diagrams/core/parts/parts.dart';

/// Renderer for all text-related parts of the diagram.
abstract class PaintedTextRenderer {
  /// Default implementation.
  const PaintedTextRenderer();

  /// Paint the [textBlock] to the [canvas] with the theme
  /// [defaultTextBlockTheme].
  void paint(
    Canvas canvas,
    TextBlock textBlock,
    TextBlockTheme defaultTextBlockTheme,
  );
}

/// Standard text painter implementation.
class StandardPaintedTextRenderer extends PaintedTextRenderer {
  /// Default implementation.
  const StandardPaintedTextRenderer();

  @override
  void paint(
    Canvas canvas,
    TextBlock textBlock,
    TextBlockTheme defaultTextBlockTheme,
  ) {
    final textSpan = TextSpan(
      text: textBlock.text,
      style: TextStyle(
        color: textBlock.themeOverride.color ?? defaultTextBlockTheme.color,
        fontSize:
            textBlock.themeOverride.fontSize ?? defaultTextBlockTheme.fontSize,
        fontWeight:
            textBlock.themeOverride.fontWeight ??
            defaultTextBlockTheme.fontWeight,
        fontFamily:
            textBlock.themeOverride.fontFamily ??
            defaultTextBlockTheme.fontFamily,
      ),
    );

    TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: textBlock.textAlign,
      )
      ..layout(minWidth: textBlock.drawWidth, maxWidth: textBlock.drawWidth)
      ..paint(canvas, Offset(textBlock.position.x, textBlock.position.y));
  }
}
