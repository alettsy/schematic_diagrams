import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

void main() {
  test('theme override if no transient theme found', () {
    final link = Link(
      id: 'A',
      fromNodeId: 'A',
      fromPortId: 'A',
      toNodeId: 'B',
      toPortId: 'B',
      inFrom: LinkDirection.bottom,
      outTo: LinkDirection.top,
      themeOverride: const LinkTheme(stroke: Colors.purple, strokeWidth: 10),
    );

    final theme = link.activeTheme;

    expect(theme.stroke, Colors.purple);
    expect(theme.strokeWidth, 10);
  });

  test('transient theme returned if not null', () {
    final link = Link(
      id: 'A',
      fromNodeId: 'A',
      fromPortId: 'A',
      toNodeId: 'B',
      toPortId: 'B',
      inFrom: LinkDirection.bottom,
      outTo: LinkDirection.top,
      themeOverride: const LinkTheme(stroke: Colors.purple, strokeWidth: 10),
    )..transientTheme = const LinkTheme(stroke: Colors.orange, strokeWidth: 5);

    final theme = link.activeTheme;

    expect(theme.stroke, Colors.orange);
    expect(theme.strokeWidth, 5);
  });
}
