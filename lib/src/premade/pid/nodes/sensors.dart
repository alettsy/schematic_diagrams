import 'package:schematic_diagrams/src/premade/pid/base/sensor_node.dart';

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
