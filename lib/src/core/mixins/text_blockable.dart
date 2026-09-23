import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';

/// Allows nodes to display text blocks relative
/// to their position.
mixin TextBlockable on Node {
  /// The text blocks that are part of this node.
  ProtectedList<TextBlock> textBlocks = ProtectedList<TextBlock>();
}
