import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/premade.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

import 'linking_test_helper.dart';

void main() {
  test('pump node has all four ports', () {
    final node = Pump(id: 'from', position: const Position(100, 100));

    expect(node.getPortOffset('top'), isNotNull);
    expect(node.getPortOffset('bottom'), isNotNull);
    expect(node.getPortOffset('left'), isNotNull);
    expect(node.getPortOffset('right'), isNotNull);
  });

  group('linking into left', () {
    const inFrom = LinkDirection.left;
    const toPort = 'left';

    test('node in top left', () {
      <StandardLinkTest>[
        StandardLinkTest(
          fromPosition: const Position(100, 100),
          fromPort: 'top',
          outTo: LinkDirection.top,
          expected: [
            (const Position(200, 216), const Position(166, 216)),
            (const Position(166, 216), const Position(166, 95)),
            (const Position(166, 95), const Position(116, 95)),
            (const Position(116, 95), const Position(116, 100)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(100, 100),
          fromPort: 'right',
          outTo: LinkDirection.right,
          expected: [
            (const Position(200, 216), const Position(166, 216)),
            (const Position(166, 216), const Position(166, 116)),
            (const Position(166, 116), const Position(132, 116)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(100, 100),
          fromPort: 'bottom',
          outTo: LinkDirection.bottom,
          expected: [
            (const Position(200, 216), const Position(116, 216)),
            (const Position(116, 216), const Position(116, 132)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(100, 100),
          fromPort: 'left',
          outTo: LinkDirection.left,
          expected: [
            (const Position(100, 116), const Position(95, 116)),
            (const Position(95, 116), const Position(95, 216)),
            (const Position(95, 216), const Position(200, 216)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
      ].forEach(testStandardLink);
    });

    test('node in top center', () {
      <StandardLinkTest>[
        StandardLinkTest(
          fromPosition: const Position(200, 100),
          fromPort: 'top',
          outTo: LinkDirection.top,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(195, 95)),
            (const Position(195, 95), const Position(216, 95)),
            (const Position(216, 95), const Position(216, 100)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(200, 100),
          fromPort: 'right',
          outTo: LinkDirection.right,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(216, 216)),
            (const Position(216, 216), const Position(216, 116)),
            (const Position(216, 116), const Position(232, 116)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(200, 100),
          fromPort: 'bottom',
          outTo: LinkDirection.bottom,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(195, 166)),
            (const Position(195, 166), const Position(216, 166)),
            (const Position(216, 166), const Position(216, 132)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(200, 100),
          fromPort: 'left',
          outTo: LinkDirection.left,
          expected: [
            (const Position(200, 116), const Position(195, 116)),
            (const Position(195, 116), const Position(195, 216)),
            (const Position(195, 216), const Position(200, 216)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
      ].forEach(testStandardLink);
    });

    test('node in top right', () {
      <StandardLinkTest>[
        StandardLinkTest(
          fromPosition: const Position(300, 100),
          fromPort: 'top',
          outTo: LinkDirection.top,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(195, 95)),
            (const Position(195, 95), const Position(316, 95)),
            (const Position(316, 95), const Position(316, 100)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(300, 100),
          fromPort: 'right',
          outTo: LinkDirection.right,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(266, 216)),
            (const Position(266, 216), const Position(266, 116)),
            (const Position(266, 116), const Position(332, 116)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(300, 100),
          fromPort: 'bottom',
          outTo: LinkDirection.bottom,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(195, 166)),
            (const Position(195, 166), const Position(316, 166)),
            (const Position(316, 166), const Position(316, 132)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(300, 100),
          fromPort: 'left',
          outTo: LinkDirection.left,
          expected: [
            (const Position(300, 116), const Position(195, 116)),
            (const Position(195, 116), const Position(195, 216)),
            (const Position(195, 216), const Position(200, 216)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
      ].forEach(testStandardLink);
    });

    test('node in middle left', () {
      <StandardLinkTest>[
        StandardLinkTest(
          fromPosition: const Position(100, 200),
          fromPort: 'top',
          outTo: LinkDirection.top,
          expected: [
            (const Position(200, 216), const Position(166, 216)),
            (const Position(166, 216), const Position(166, 195)),
            (const Position(166, 195), const Position(116, 195)),
            (const Position(116, 195), const Position(116, 200)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(100, 200),
          fromPort: 'right',
          outTo: LinkDirection.right,
          expected: [(const Position(200, 216), const Position(132, 216))],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(100, 200),
          fromPort: 'bottom',
          outTo: LinkDirection.bottom,
          expected: [
            (const Position(200, 216), const Position(166, 216)),
            (const Position(166, 216), const Position(166, 237)),
            (const Position(166, 237), const Position(116, 237)),
            (const Position(116, 237), const Position(116, 232)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(100, 200),
          fromPort: 'left',
          outTo: LinkDirection.left,
          expected: [
            (const Position(100, 216), const Position(95, 216)),
            (const Position(95, 216), const Position(95, 237)),
            (const Position(95, 237), const Position(166, 237)),
            (const Position(166, 237), const Position(166, 216)),
            (const Position(166, 216), const Position(200, 216)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
      ].forEach(testStandardLink);
    });

    test('node in middle right', () {
      <StandardLinkTest>[
        StandardLinkTest(
          fromPosition: const Position(300, 200),
          fromPort: 'top',
          outTo: LinkDirection.top,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(195, 195)),
            (const Position(195, 195), const Position(316, 195)),
            (const Position(316, 195), const Position(316, 200)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(300, 200),
          fromPort: 'right',
          outTo: LinkDirection.right,
          expected: [
            (const Position(200, 208), const Position(195, 208)),
            (const Position(195, 208), const Position(266, 208)),
            (const Position(266, 216), const Position(266, 208)),
            (const Position(266, 216), const Position(332, 216)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(300, 200),
          fromPort: 'bottom',
          outTo: LinkDirection.bottom,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(195, 237)),
            (const Position(195, 237), const Position(316, 237)),
            (const Position(316, 237), const Position(316, 232)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(300, 200),
          fromPort: 'left',
          outTo: LinkDirection.left,
          expected: [
            (const Position(300, 216), const Position(266, 216)),
            (const Position(266, 216), const Position(266, 237)),
            (const Position(266, 237), const Position(195, 237)),
            (const Position(195, 237), const Position(195, 216)),
            (const Position(195, 216), const Position(200, 216)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
      ].forEach(testStandardLink);
    });

    test('node in bottom left', () {
      <StandardLinkTest>[
        StandardLinkTest(
          fromPosition: const Position(100, 300),
          fromPort: 'top',
          outTo: LinkDirection.top,
          expected: [
            (const Position(200, 216), const Position(116, 216)),
            (const Position(116, 216), const Position(116, 300)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(100, 300),
          fromPort: 'right',
          outTo: LinkDirection.right,
          expected: [
            (const Position(200, 216), const Position(166, 216)),
            (const Position(166, 216), const Position(166, 316)),
            (const Position(166, 316), const Position(132, 316)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(100, 300),
          fromPort: 'bottom',
          outTo: LinkDirection.bottom,
          expected: [
            (const Position(200, 216), const Position(166, 216)),
            (const Position(166, 216), const Position(166, 337)),
            (const Position(166, 337), const Position(116, 337)),
            (const Position(116, 337), const Position(116, 332)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(100, 300),
          fromPort: 'left',
          outTo: LinkDirection.left,
          expected: [
            (const Position(100, 316), const Position(95, 316)),
            (const Position(95, 316), const Position(95, 216)),
            (const Position(95, 216), const Position(200, 216)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
      ].forEach(testStandardLink);
    });

    test('node in bottom center', () {
      <StandardLinkTest>[
        StandardLinkTest(
          fromPosition: const Position(200, 300),
          fromPort: 'top',
          outTo: LinkDirection.top,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(195, 266)),
            (const Position(195, 266), const Position(216, 266)),
            (const Position(216, 266), const Position(216, 300)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(200, 300),
          fromPort: 'right',
          outTo: LinkDirection.right,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(216, 216)),
            (const Position(216, 216), const Position(216, 316)),
            (const Position(216, 316), const Position(232, 316)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(200, 300),
          fromPort: 'bottom',
          outTo: LinkDirection.bottom,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(195, 337)),
            (const Position(195, 337), const Position(216, 337)),
            (const Position(216, 337), const Position(216, 332)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(200, 300),
          fromPort: 'left',
          outTo: LinkDirection.left,
          expected: [
            (const Position(200, 316), const Position(195, 316)),
            (const Position(195, 316), const Position(195, 216)),
            (const Position(195, 216), const Position(200, 216)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
      ].forEach(testStandardLink);
    });

    test('node in bottom right', () {
      <StandardLinkTest>[
        StandardLinkTest(
          fromPosition: const Position(300, 300),
          fromPort: 'top',
          outTo: LinkDirection.top,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(195, 266)),
            (const Position(195, 266), const Position(316, 266)),
            (const Position(316, 266), const Position(316, 300)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(300, 300),
          fromPort: 'right',
          outTo: LinkDirection.right,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(266, 216)),
            (const Position(266, 216), const Position(266, 316)),
            (const Position(266, 316), const Position(332, 316)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(300, 300),
          fromPort: 'bottom',
          outTo: LinkDirection.bottom,
          expected: [
            (const Position(200, 216), const Position(195, 216)),
            (const Position(195, 216), const Position(195, 337)),
            (const Position(195, 337), const Position(316, 337)),
            (const Position(316, 337), const Position(316, 332)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
        StandardLinkTest(
          fromPosition: const Position(300, 300),
          fromPort: 'left',
          outTo: LinkDirection.left,
          expected: [
            (const Position(300, 316), const Position(195, 316)),
            (const Position(195, 316), const Position(195, 216)),
            (const Position(195, 216), const Position(200, 216)),
          ],
          inFrom: inFrom,
          toPort: toPort,
        ),
      ].forEach(testStandardLink);
    });
  });
}
