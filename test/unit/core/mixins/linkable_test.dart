import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

void main() {
  test('Linkable node has port functionality', () {
    final node = _TestNode(
      id: 'A',
      ports: [const Port(id: 'port1', position: Position(10, 10))].protected,
    );

    expect(node.getPortOffset('port1'), const Position(10, 10));
  });
}

class _TestNode extends Node with Linkable {
  _TestNode({required super.id, required ProtectedList<Port> ports})
    : super(renderer: DesignlessRenderer()) {
    this.ports = ports;
  }
}
