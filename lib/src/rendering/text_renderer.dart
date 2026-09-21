import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';

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
