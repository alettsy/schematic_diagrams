import 'package:schematic_diagrams/models/node.dart';

/// Allows nodes to update themselves, rather than
/// remaing static.
mixin Updatable on Node {
  /// Describes how to update this node.
  void update();
}
