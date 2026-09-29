import 'package:schematic_diagrams/src/premade/pid/base/indicator_node.dart';

/// P&ID standard implementation for a voltage indicator node, indicated
/// by the tag "VI".
class VoltageIndicator extends IndicatorNode {
  /// Create a [VoltageIndicator] qith a unique [id].
  VoltageIndicator({
    required super.id,
    super.position,
    super.title,
    super.showValue,
  }) : super(prefix: 'VI');
}

/// P&ID standard implementation for a flow indicator node, indicated
/// by the tag "FI".
class FlowIndicator extends IndicatorNode {
  /// Create a [FlowIndicator] qith a unique [id].
  FlowIndicator({
    required super.id,
    super.position,
    super.title,
    super.showValue,
  }) : super(prefix: 'FI');
}

/// P&ID standard implementation for a pressure indicator node, indicated
/// by the tag "PI".
class PressureIndicator extends IndicatorNode {
  /// Create a [PressureIndicator] qith a unique [id].
  PressureIndicator({
    required super.id,
    super.position,
    super.title,
    super.showValue,
  }) : super(prefix: 'PI');
}

/// P&ID standard implementation for a level indicator node, indicated
/// by the tag "LI".
class LevelIndicator extends IndicatorNode {
  /// Create a [LevelIndicator] qith a unique [id].
  LevelIndicator({
    required super.id,
    super.position,
    super.title,
    super.showValue,
  }) : super(prefix: 'LI');
}
