import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/premade.dart';
import 'package:schematic_diagrams/src/core/core.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_path_strategy.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_section_manager.dart';
import 'package:schematic_diagrams/src/models/models.dart';

class StandardLinkTest {
  StandardLinkTest({
    required this.fromPosition,
    required this.fromPort,
    required this.outTo,
    required this.expected,
    required this.inFrom,
    required this.toPort,
  });

  final Position fromPosition;
  final String fromPort;
  final LinkDirection outTo;
  final LinkDirection inFrom;
  final String toPort;
  final List<(Position, Position)> expected;
}

void testStandardLink(StandardLinkTest testCase) {
  final fromNode = Pump(id: 'from', position: testCase.fromPosition);
  final toNode = Pump(id: 'to', position: const Position(200, 200));

  final link = Link(
    id: 'link-${testCase.fromPosition.x}-${testCase.fromPosition.y}',
    fromNodeId: fromNode.id,
    toNodeId: toNode.id,
    fromPortId: testCase.fromPort,
    toPortId: testCase.toPort,
    outTo: testCase.outTo,
    inFrom: testCase.inFrom,
  );

  final model = SchematicDiagramModel(
    nodes: [fromNode, toNode].protected,
    links: [link].protected,
  );

  final strategy = StandardLinkPathStrategy(
    sectionManager: StandardSectionManager(),
  );

  final lines = strategy.compute(link, model);

  expect(
    lines,
    isNotEmpty,
    reason: 'Routes missing - ${testCase.outTo.name}: ${testCase.fromPosition}',
  );

  expect(
    lines.map((l) => (l.from, l.to)),
    testCase.expected,
    reason: '${testCase.outTo.name} to ${testCase.inFrom.name} failed',
  );
}
