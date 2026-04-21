import '../../models/node.dart';
import '../parts/text_block.dart';

mixin TextBlockable on Node {
  List<TextBlock> textBlocks = [];
}
