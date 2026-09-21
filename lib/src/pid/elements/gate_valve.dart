import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/pid/base/common_node.dart';
import 'package:schematic_diagrams/src/pid/renderers/gate_valve_renderer.dart';

class GateValve extends CommonNode {
  GateValve({
    required super.id,
    super.position,
    super.rotation,
    super.size = const Size(28, 32),
  }) : super(renderer: GateValveRenderer()) {
    final halfWidth = size.width / 2;
    ports = [
      Port(id: 'top', position: Position(halfWidth, 0)),
      Port(id: 'bottom', position: Position(halfWidth, size.height)),
    ];
  }

  @override
  void update() {
    if (value == null) return;

    if (value! > 500) {
      setPartThemeOverride(0, const NodeTheme(fill: Colors.orange));
      setPartThemeOverride(1, const NodeTheme(fill: Colors.green));
    } else {
      setPartThemeOverride(0, const NodeTheme(fill: Colors.purple));
      setPartThemeOverride(1, const NodeTheme(fill: Colors.brown));
    }

    super.update();
  }
}
