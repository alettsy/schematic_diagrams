import 'package:flutter/widgets.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/rendering/text_renderer.dart';

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
