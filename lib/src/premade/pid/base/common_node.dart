import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/mixins/mixins.dart';
import 'package:schematic_diagrams/src/core/parts/position.dart';
import 'package:schematic_diagrams/src/core/parts/text_block.dart';
import 'package:schematic_diagrams/src/models/models.dart';

/// Base common P&ID node, used for the creation of other P&ID nodes, such as
/// the pump and gate valve.
abstract class CommonNode extends Node
    with ChangeNotifier, Updatable, Valuable<double>, TextBlockable, Linkable {
  /// Default implementation.
  CommonNode({
    required super.id,
    required super.renderer,
    super.position,
    super.size,
    super.rotation,
    this.title,
    this.showValue = true,
  }) {
    if (title != null) {
      textBlocks.add(
        TextBlock(
          id: 'title',
          text: title!,
          position: Position(size.width + 5, size.height * 0),
        ),
      );
    }

    if (showValue) {
      textBlocks.add(
        TextBlock(
          id: 'value',
          text: '0',
          position: Position(size.width + 5, size.height * 0.5),
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
    for (var i = 0; i < textBlocks.length; i++) {
      if (textBlocks[i].id == 'value') {
        textBlocks[i] = textBlocks[i].copyWith(text: value.toString());
      }
    }

    notifyListeners();
  }
}
