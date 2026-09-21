import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/pid/base/common_node.dart';
import 'package:schematic_diagrams/src/pid/renderers/three_way_valve_renderer.dart';

class ThreeWayValve extends CommonNode {
  ThreeWayValve({
    required super.id,
    super.position,
    super.rotation,
    super.size = const Size(28, 32),
  }) : super(renderer: ThreeWayValveRenderer()) {
    final halfWidth = size.width / 2;
    ports = [
      Port(id: 'top', position: Position(halfWidth, 0)),
      Port(id: 'bottom', position: Position(halfWidth, size.height)),
    ];
  }
}
