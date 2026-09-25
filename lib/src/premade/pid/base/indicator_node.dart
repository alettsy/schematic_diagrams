import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/premade/pid/base/common_node.dart';
import 'package:schematic_diagrams/src/premade/pid/renderers/circular_pid_renderer.dart';

/// Base indicator/sensor node, used for the creation of simple circular
/// P&ID elements, such as a voltage indicator.
abstract class IndicatorNode extends CommonNode {
  /// Create an [IndicatorNode] with a unique [id] and center title [prefix].
  /// 
  /// Used as a base for all indicators, such as the VoltageIndicator node.
  IndicatorNode({
    required this.prefix,
    required super.id,
    super.title,
    super.showValue = true,
    super.position,
    this.threshold = 0,
    super.size,
  }) : super(renderer: CircularPaintedNodeRenderer<IndicatorNode>()) {
    textBlocks.add(
      TextBlock(
        id: 'prefix',
        text: prefix,
        position: Position(0, size.height * 0.25),
        drawWidth: size.width,
        textAlign: TextAlign.center,
      ),
    );

    final halfHeight = size.height / 2;
    final halfWidth = size.width / 2;

    ports = ProtectedList([
      Port(id: 'top', position: Position(halfWidth, 0)),
      Port(id: 'bottom', position: Position(halfWidth, size.height)),
      Port(id: 'left', position: Position(0, halfHeight)),
      Port(id: 'right', position: Position(size.width, halfHeight)),
    ]);
  }

  /// Tag displayed in the center of the circle.
  final String prefix;

  /// Threshold value for the node to turn "on".
  ///
  /// For example, if [threshold] is 0, then when [threshold] > 0
  /// the node will switch "on".
  final double threshold;

  @override
  void update() {
    if (value == null) return;

    if (value! > threshold) {
      transientTheme = themeOverride.copyWith(fill: Colors.green);
    } else {
      transientTheme = themeOverride;
    }

    super.update();
  }
}
