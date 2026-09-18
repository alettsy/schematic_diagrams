import 'package:schematic_diagrams/core/mixins/updatable.dart';
import 'package:schematic_diagrams/models/node.dart';

/// Allows nodes to maintain a value that can be
/// used for various actions, like updating.
mixin Valuable<T> on Updatable, Node {
  T? _value;

  /// The current value held by this node.
  T? get value => _value;

  set value(T newValue) {
    _value = newValue;
    update();
  }
}
