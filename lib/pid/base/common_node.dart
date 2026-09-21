import 'package:flutter/material.dart';
import 'package:schematic_diagrams/core/mixins/mixins.dart';
import 'package:schematic_diagrams/core/parts/position.dart';
import 'package:schematic_diagrams/core/parts/text_block.dart';
import 'package:schematic_diagrams/models/models.dart';

abstract class CommonNode extends Node
    with
        ChangeNotifier,
        Updatable,
        Valuable<double>,
        TextBlockable,
        Linkable,
        StateToColorMappable<double> {
  CommonNode({
    required super.id,
    required super.renderer,
    super.position,
    super.size,
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
}
