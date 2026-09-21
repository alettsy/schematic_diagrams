import 'package:flutter/widgets.dart';
import 'package:schematic_diagrams/pid/renderers/gate_valve_renderer.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

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
