import 'package:schematic_diagrams/core/parts/port.dart';
import 'package:schematic_diagrams/core/parts/position.dart';
import 'package:schematic_diagrams/models/node.dart';

/// Allows nodes to be linked together via "ports".
///
/// Connect a port from one node to another using the port ID
/// and specified draw direction.
mixin Linkable on Node {
  /// Available ports for linking on this node.
  List<Port> ports = [];

  /// Get the port placement offset from the node position.
  Position? getPortOffset(String portId) {
    for (final port in ports) {
      if (port.id == portId) {
        return port.position + position;
      }
    }

    return null;
  }
}
