import 'package:flutter/widgets.dart';
import 'package:schematic_diagrams/src/core/mixins/mixins.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/premade/pid/renderers/io_renderer.dart';

/// Triangular P&ID IO node, with an optional label.
class IoNode extends Node with TextBlockable, Linkable {
  /// Default implementation.
  IoNode({
    required super.id,
    super.position,
    super.size = const Size(10, 18),
    super.rotation,
    super.themeOverride,
    this.label,
  }) : super(renderer: IoRenderer()) {
    if (label != null) {
      textBlocks.add(
        TextBlock(
          id: 'label',
          text: label!,
          position: Position(size.width + 5, size.height * 0),
        ),
      );
    }

    ports = ProtectedList([
      Port(id: 'top', position: Position(size.width / 2, 0)),
      Port(id: 'bottom', position: Position(size.width / 2, size.height)),
    ]);
  }

  /// The optional label for this IO node.
  final String? label;
}
