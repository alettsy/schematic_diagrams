import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/premade/pid/base/common_node.dart';
import 'package:schematic_diagrams/src/premade/pid/renderers/pump_pid_renderer.dart';

/// Standard P&ID pump.
class Pump extends CommonNode {
  /// Default implementation.
  Pump({
    required super.id,
    super.position,
    super.rotation,
    super.size,
    super.title,
    super.showValue,
    super.themeOverride,
  }) : super(renderer: PumpRenderer()) {
    final halfHeight = size.height / 2;
    final halfWidth = size.width / 2;

    ports = ProtectedList([
      Port(id: 'top', position: Position(halfWidth, 0)),
      Port(id: 'bottom', position: Position(halfWidth, size.height)),
      Port(id: 'left', position: Position(0, halfHeight)),
      Port(id: 'right', position: Position(size.width, halfHeight)),
    ]);
  }
}
