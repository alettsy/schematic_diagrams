import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/pid/base/common_node.dart';
import 'package:schematic_diagrams/src/pid/renderers/circular_pid_renderer.dart';

/// Base indicator/sensor node, used for the creation of simple circular
/// P&ID elements, such as a voltage indicator.
abstract class SensorNode extends CommonNode {
  /// Default implementation.
  SensorNode({
    required this.prefix,
    required super.id,
    super.title,
    super.showValue = true,
    super.position,
    this.threshold = 0,
    Size size = const Size(32, 32),
  }) : super(renderer: CircularPaintedNodeRenderer<SensorNode>(), size: size) {
    textBlocks.add(
      TextBlock(
        id: 'prefix',
        text: prefix,
        position: Position(0, size.height * 0.25),
        drawWidth: size.width,
        textAlign: TextAlign.center,
      ),
    );

    ports = [
      const Port(id: 'top', position: Position(16, 0)),
      const Port(id: 'bottom', position: Position(16, 32)),
      const Port(id: 'left', position: Position(0, 16)),
      const Port(id: 'right', position: Position(32, 16)),
    ];
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

    for (var i = 0; i < textBlocks.length; i++) {
      if (textBlocks[i].id == 'value') {
        textBlocks[i] = textBlocks[i].copyWith(text: value.toString());
      }
    }

    if (value! > threshold) {
      transientTheme = themeOverride.copyWith(fill: Colors.green);
    } else {
      transientTheme = themeOverride.copyWith(fill: Colors.red);
    }

    notifyListeners();
  }
}

/// P&ID standard implementation for a voltage indicator node, indicated
/// by the tag "VI".
class VoltageSensorNode extends SensorNode {
  /// Default implementation.
  VoltageSensorNode({
    required super.id,
    super.position,
    super.title,
    super.showValue,
  }) : super(prefix: 'VI');
}

/// P&ID standard implementation for a flow indicator node, indicated
/// by the tag "FI".
class FlowSensorNode extends SensorNode {
  /// Default implementation.
  FlowSensorNode({
    required super.id,
    super.position,
    super.title,
    super.showValue,
  }) : super(prefix: 'FI');
}

/// P&ID standard implementation for a pressure indicator node, indicated
/// by the tag "PI".
class PressureIndicator extends SensorNode {
  /// Default implementation.
  PressureIndicator({
    required super.id,
    super.position,
    super.title,
    super.showValue,
  }) : super(prefix: 'PI');
}

/// P&ID standard implementation for a level indicator node, indicated
/// by the tag "LI".
class LevelIndicator extends SensorNode {
  /// Default implementation.
  LevelIndicator({
    required super.id,
    super.position,
    super.title,
    super.showValue,
  }) : super(prefix: 'LI');
}
