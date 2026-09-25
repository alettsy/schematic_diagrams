import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/premade/pid/base/common_node.dart';
import 'package:schematic_diagrams/src/premade/pid/renderers/three_way_valve_renderer.dart';

/// Standard P&ID three-way valve.
class ThreeWayValve extends CommonNode {
  /// Create a [ThreeWayValve] node with a unique [id].
  ThreeWayValve({
    required super.id,
    super.position,
    super.rotation,
    super.title,
    super.showValue,
    super.themeOverride,
    super.size = const Size(30, 34),
  }) : super(renderer: ThreeWayValveRenderer()) {
    final thirdWidth = size.width / 3;
    ports = ProtectedList([
      Port(id: 'top', position: Position(thirdWidth, 0)),
      Port(id: 'bottom', position: Position(thirdWidth, size.height)),
      Port(id: 'right', position: Position(size.width, size.height / 2)),
    ]);
  }

  @override
  void update() {
    if (value == null) return;

    if (value! > 0) {
      setPartThemeOverride(0, const NodeTheme(fill: Colors.green));
      setPartThemeOverride(1, const NodeTheme(fill: Colors.green));
      setPartThemeOverride(2, const NodeTheme(fill: Colors.green));
    } else {
      setPartThemeOverride(0, null);
      setPartThemeOverride(1, null);
      setPartThemeOverride(2, null);
    }

    super.update();
  }
}
