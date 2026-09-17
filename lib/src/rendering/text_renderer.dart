import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';

abstract class PaintedTextRenderer {
  const PaintedTextRenderer();

  void paint(
    Canvas canvas,
    TextBlock textBlock,
    TextBlockTheme defaultTextBlockTheme,
  );
}

class StandardPaintedTextRenderer extends PaintedTextRenderer {
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

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: textBlock.textAlign,
    );

    textPainter.layout(
      minWidth: textBlock.drawWidth,
      maxWidth: textBlock.drawWidth,
    );

    textPainter.paint(
      canvas,
      Offset(textBlock.position.x, textBlock.position.y),
    );
  }
}
