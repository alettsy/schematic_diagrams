import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

void main() {
  test('TextBlockable node can have text blocks', () {
    final node = _TestNode(
      id: 'A',
      textBlocks: [TextBlock(id: 'test', text: 'first')].protected,
    );

    expect(node.textBlocks.length, 1);
  });

  test('setTextById updates text block text by its ID', () {
    final node = _TestNode(
      id: 'A',
      textBlocks: [TextBlock(id: 'test', text: 'first')].protected,
    );

    expect(node.textBlocks.first.text, 'first');

    node.setTextById('test', 'second');

    expect(node.textBlocks.first.text, 'second');
  });

  test('setTextById does nothing if ID not found', () {
    final node = _TestNode(
      id: 'A',
      textBlocks: [TextBlock(id: 'test', text: 'first')].protected,
    );

    expect(node.textBlocks.first.text, 'first');

    node.setTextById('non-existent', 'second');

    expect(node.textBlocks.first.text, 'first');
  });

  test('setTextBlockById updates text block properties by its ID', () {
    final node = _TestNode(
      id: 'A',
      textBlocks: [TextBlock(id: 'test', text: 'first')].protected,
    );

    expect(node.textBlocks.first.text, 'first');
    expect(node.textBlocks.first.position, const Position(0, 0));

    node.setTextBlockById(
      'test',
      (block) =>
          block.copyWith(text: 'second', position: const Position(100, 100)),
    );

    expect(node.textBlocks.first.text, 'second');
    expect(node.textBlocks.first.position, const Position(100, 100));
  });

  test('setTextBlockById does nothing if ID not found', () {
    final node = _TestNode(
      id: 'A',
      textBlocks: [TextBlock(id: 'test', text: 'first')].protected,
    );

    expect(node.textBlocks.first.text, 'first');
    expect(node.textBlocks.first.position, const Position(0, 0));

    node.setTextBlockById(
      'non-existent',
      (block) =>
          block.copyWith(text: 'second', position: const Position(100, 100)),
    );

    expect(node.textBlocks.first.text, 'first');
    expect(node.textBlocks.first.position, const Position(0, 0));
  });
}

class _TestNode extends Node with TextBlockable {
  _TestNode({required super.id, required ProtectedList<TextBlock> textBlocks})
    : super(renderer: DesignlessRenderer()) {
    this.textBlocks = textBlocks;
  }
}
