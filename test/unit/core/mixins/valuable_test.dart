import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

void main() {
  test('Valuable node has value', () {
    final node = _TestNode(id: 'A');
    expect(node.value, null);
  });

  test('Valuable triggers update on value change', () {
    var wasTriggered = false;
    bool callback() => wasTriggered = true;

    final node = _TestNode(id: 'A', callback: callback);

    expect(wasTriggered, isFalse);

    node.value = 22;

    expect(wasTriggered, isTrue);
  });
}

class _TestNode extends Node with Updatable, Valuable<double> {
  _TestNode({required super.id, this.callback})
    : super(renderer: DesignlessRenderer());

  final VoidCallback? callback;

  @override
  void update() {
    callback?.call();
  }
}
