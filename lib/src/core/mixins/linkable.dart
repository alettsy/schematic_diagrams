import '../../models/node.dart';
import '../parts/port.dart';
import '../parts/position.dart';

mixin Linkable on Node {
  List<Port> ports = [];

  Position? getPortOffset(String portId) {
    for (final port in ports) {
      if (port.id == portId) {
        return port.position + position;
      }
    }

    return null;
  }
}
