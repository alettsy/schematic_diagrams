import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/premade/pid/base/common_node.dart';
import 'package:schematic_diagrams/src/premade/pid/renderers/gate_valve_renderer.dart';

/// Standard P&ID two-port gate valve.
class GateValve extends CommonNode {
  /// Default implementation.
  GateValve({
    required super.id,
    super.position,
    super.rotation,
    super.title,
    super.showValue = false,
    super.size = const Size(24, 32),
    super.themeOverride,
  }) : super(renderer: GateValveRenderer()) {
    final halfWidth = size.width / 2;
    ports = ProtectedList([
      Port(id: 'top', position: Position(halfWidth, 0)),
      Port(id: 'bottom', position: Position(halfWidth, size.height)),
    ]);
  }

  @override
  void update() {
    if (value == null) return;

    if (value! > 0) {
      setPartThemeOverride(0, const NodeTheme(fill: Colors.green));
      setPartThemeOverride(1, const NodeTheme(fill: Colors.green));
    } else {
      setPartThemeOverride(0, null);
      setPartThemeOverride(1, null);
    }

    super.update();
  }
}
