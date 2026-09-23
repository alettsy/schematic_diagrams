import 'package:flutter/widgets.dart';
import 'package:schematic_diagrams/src/core/helpers/angle_helper.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/rendering/text_renderer.dart';

/// Standard text painter implementation.
class StandardPaintedTextRenderer extends PaintedTextRenderer {
  /// Default implementation.
  const StandardPaintedTextRenderer();

  @override
  void paint(
    Canvas canvas,
    TextBlock textBlock,
    Node parentNode,
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

    canvas
      ..save()
      ..translate(textBlock.position.x, textBlock.position.y)
      ..rotate(-parentNode.rotation.radians + textBlock.rotation.radians);

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: textBlock.textAlign,
    );

    textPainter
      ..layout(minWidth: textBlock.drawWidth, maxWidth: textBlock.drawWidth)
      ..paint(canvas, Offset(0, -textPainter.height / 2));

    canvas.restore();
  }
}
