import 'package:schematic_diagrams/core/parts/text_block.dart';
import 'package:schematic_diagrams/models/node.dart';

/// Allows nodes to display text blocks relative
/// to their position.
mixin TextBlockable on Node {
  /// The text blocks that are part of this node.
  List<TextBlock> textBlocks = [];
}
