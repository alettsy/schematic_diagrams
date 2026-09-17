import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/mixins/mixins.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/pid/renderers/circular_pid_renderer.dart';

/// Base indicator/sensor node, used for the creation of simple circular
/// P&ID elements, such as a voltage indicator.
abstract class SensorNode extends Node
    with
        ChangeNotifier,
        Updatable,
        Valuable<double>,
        TextBlockable,
        Linkable,
        StateToColorMappable<double> {
  SensorNode({
    required this.prefix,
    required super.id,
    this.title,
    this.showValue = true,
    Size size = const Size(32, 32),
    this.threshold = 0,
    super.position,
  }) : super(renderer: CircularPaintedNodeRenderer<SensorNode>(), size: size) {
    textBlocks = [
      TextBlock(
        id: 'prefix',
        text: prefix,
        position: Position(0, size.height * 0.25),
        drawWidth: size.width,
        textAlign: TextAlign.center,
      ),
    ];

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

  /// The node name or title.
  final String? title;

  /// Whether or not to show the numerical value next to the sensor.
  final bool showValue;

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
  LevelIndicator({
    required super.id,
    super.position,
    super.title,
    super.showValue,
  }) : super(prefix: 'LI');
}
