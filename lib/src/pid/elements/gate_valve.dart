import 'package:flutter/widgets.dart';
import 'package:schematic_diagrams/src/core/mixins/mixins.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/models.dart';
import 'package:schematic_diagrams/src/pid/renderers/gate_valve_renderer.dart';

class GateValve extends Node
    with
        ChangeNotifier,
        Updatable,
        Valuable<double>,
        TextBlockable,
        Linkable,
        StateToColorMappable<double> {
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
    // TODO: implement update
  }
}
