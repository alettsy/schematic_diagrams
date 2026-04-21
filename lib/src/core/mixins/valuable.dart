import '../../models/node.dart';
import 'updatable.dart';

mixin Valuable<T> on Updatable, Node {
  T? _value;
  T? get value => _value;

  set value(T newValue) {
    _value = newValue;
    update();
  }
}
