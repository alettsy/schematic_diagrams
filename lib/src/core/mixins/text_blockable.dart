import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';

/// Allows nodes to display text blocks relative
/// to their position.
mixin TextBlockable on Node {
  /// The text blocks that are part of this node.
  ProtectedList<TextBlock> textBlocks = ProtectedList<TextBlock>();

  /// Update a text block [text] by [id].
  void setTextById(String id, String text) {
    final index = textBlocks.indexWhere((t) => t.id == id);

    if (index == -1) return;

    textBlocks[index] = textBlocks[index].copyWith(text: text);
  }

  /// Update a text block by [id].
  void setTextBlockById(String id, TextBlock Function(TextBlock) updater) {
    final index = textBlocks.indexWhere((t) => t.id == id);

    if (index == -1) return;

    textBlocks[index] = updater(textBlocks[index]);
  }
}
