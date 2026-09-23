import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:schematic_diagrams/src/core/helpers/angle_helper.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';

/// Allows nodes to be linked together via "ports".
///
/// Connect a port from one node to another using the port ID
/// and specified draw direction.
mixin Linkable on Node {
  /// Available ports for linking on this node.
  ProtectedList<Port> ports = ProtectedList<Port>();

  /// Get the port placement offset from the node position.
  Position? getPortOffset(String portId) {
    for (final port in ports) {
      if (port.id != portId) continue;

      final center = Offset(size.width / 2, size.height / 2);
      final local = port.position.asOffset - center;
      final angle = rotation.radians;

      final rotated = Offset(
        local.dx * math.cos(angle) - local.dy * math.sin(angle),
        local.dx * math.sin(angle) + local.dy * math.cos(angle),
      );

      return Position(
        position.x + center.dx + rotated.dx,
        position.y + center.dy + rotated.dy,
      );
    }

    return null;
  }
}
