import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';
import 'package:schematic_diagrams/src/internal/models/lines/jump_line.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_path_strategy.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_section_manager.dart';
import 'package:schematic_diagrams/src/premade/pid/pid.dart';

void main() {
  test('pump node has all four ports', () {
    final node = Pump(id: 'from', position: const Position(100, 100));

    expect(node.getPortOffset('top'), isNotNull);
    expect(node.getPortOffset('bottom'), isNotNull);
    expect(node.getPortOffset('left'), isNotNull);
    expect(node.getPortOffset('right'), isNotNull);
  });

  test('horizontal jump inserted at intersection', () {
    final node1 = Pump(id: 'node1', position: const Position(100, 100));
    final node2 = Pump(id: 'node2', position: const Position(100, 300));

    final node3 = Pump(id: 'node3', position: const Position(0, 200));
    final node4 = Pump(id: 'node4', position: const Position(200, 200));

    final horizontalLink = Link(
      id: 'horizontal',
      fromNodeId: 'node3',
      toNodeId: 'node4',
      fromPortId: 'right',
      toPortId: 'left',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.right,
    );

    final verticalLink = Link(
      id: 'vertical',
      fromNodeId: 'node1',
      toNodeId: 'node2',
      fromPortId: 'bottom',
      toPortId: 'top',
      inFrom: LinkDirection.top,
      outTo: LinkDirection.bottom,
    );

    final model = SchematicDiagramModel(
      nodes: [node1, node2, node3, node4].protected,
      links: [horizontalLink, verticalLink].protected,
    );

    final strategy = StandardLinkPathStrategy(
      sectionManager: StandardSectionManager(),
    )..compute(verticalLink, model);

    final lines = strategy.compute(horizontalLink, model);

    final jumps = lines.fold(<JumpLine>[], (list, line) {
      if (line is JumpLine) list.add(line);
      return list;
    });

    expect(jumps.length, 1);
    expect(jumps.first.from, const Position(124, 216));
    expect(jumps.first.to, const Position(108, 216));
  });

  test('vertical jump inserted at intersection', () {
    final node1 = Pump(id: 'node1', position: const Position(100, 100));
    final node2 = Pump(id: 'node2', position: const Position(100, 300));

    final node3 = Pump(id: 'node3', position: const Position(0, 200));
    final node4 = Pump(id: 'node4', position: const Position(200, 200));

    final horizontalLink = Link(
      id: 'horizontal',
      fromNodeId: 'node3',
      toNodeId: 'node4',
      fromPortId: 'right',
      toPortId: 'left',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.right,
    );

    final verticalLink = Link(
      id: 'vertical',
      fromNodeId: 'node1',
      toNodeId: 'node2',
      fromPortId: 'bottom',
      toPortId: 'top',
      inFrom: LinkDirection.top,
      outTo: LinkDirection.bottom,
    );

    final model = SchematicDiagramModel(
      nodes: [node1, node2, node3, node4].protected,
      links: [horizontalLink, verticalLink].protected,
    );

    final strategy = StandardLinkPathStrategy(
      sectionManager: StandardSectionManager(),
    )..compute(horizontalLink, model);

    final lines = strategy.compute(verticalLink, model);

    final jumps = lines.fold(<JumpLine>[], (list, line) {
      if (line is JumpLine) list.add(line);
      return list;
    });

    expect(jumps.length, 1);
    expect(jumps.first.from, const Position(116, 208));
    expect(jumps.first.to, const Position(116, 224));
  });
}
