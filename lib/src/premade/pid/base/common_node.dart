import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/core.dart';
import 'package:schematic_diagrams/src/models/models.dart';

/// Base common P&ID node, used for the creation of other P&ID nodes, such as
/// the pump and gate valve.
abstract class CommonNode extends Node
    with ChangeNotifier, Updatable, Valuable<double>, TextBlockable, Linkable {
  /// Create a [CommonNode] with a unique [id] and [renderer].
  ///
  /// Used as a base for commonly seen P&ID nodes, such as the indicators
  /// and pumps.
  CommonNode({
    required super.id,
    required super.renderer,
    super.position,
    super.size,
    super.rotation,
    super.themeOverride,
    this.title,
    this.showValue = true,
  }) {
    final titleY = showValue ? size.height * 0.25 : size.height * 0.5;
    final valueY = title != null ? size.height * 0.75 : size.height * 0.5;

    if (title != null) {
      textBlocks.add(
        TextBlock(
          id: 'title',
          text: title!,
          position: Position(size.width + 7, titleY),
          themeOverride: const TextBlockTheme(fontWeight: FontWeight.bold),
        ),
      );
    }

    if (showValue) {
      textBlocks.add(
        TextBlock(
          id: 'value',
          text: '0',
          position: Position(size.width + 7, valueY),
        ),
      );
    }
  }

  /// The node name or title.
  final String? title;

  /// Whether or not to show the numerical value next to the sensor.
  final bool showValue;

  @override
  void update() {
    setTextById('value', value.toString());
    notifyListeners();
  }
}
