import 'package:schematic_diagrams/src/models/node.dart';

/// Allows the node to be tappable, so that actions
/// can be performed on tap.
mixin Tappable on Node {
  /// The action to perform when the node is tapped.
  void onTap();
}
