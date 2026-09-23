import 'package:schematic_diagrams/src/core/mixins/mixins.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/models.dart';
import 'package:schematic_diagrams/src/premade/pid/base/base_renderer.dart';

/// Simple text label node.
class LabelNode extends Node with TextBlockable {
  /// Default implementation.
  LabelNode({
    required super.id,
    required this.label,
    super.position,
    super.rotation,
    double drawWidth = 100,
    TextBlockTheme textBlockThemeOverride = const TextBlockTheme(),
  }) : super(renderer: BaseRenderer()) {
    textBlocks.add(
      TextBlock(
        id: 'label',
        text: label,
        themeOverride: textBlockThemeOverride,
        drawWidth: drawWidth,
      ),
    );
  }

  /// String label for this label node.
  final String label;
}
