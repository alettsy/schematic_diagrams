import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/premade.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

void main() {
  test('theme override if no transient theme found', () {
    final node = Pump(
      id: 'A',
      position: const Position(10, 10),
      themeOverride: const NodeTheme(
        fill: Colors.orange,
        stroke: Colors.purple,
        strokeWidth: 10,
      ),
    );

    final theme = node.activeThemeOverride;

    expect(theme.fill, Colors.orange);
    expect(theme.stroke, Colors.purple);
    expect(theme.strokeWidth, 10);
  });

  test('transient theme returned if not null', () {
    final node =
        Pump(
          id: 'A',
          position: const Position(10, 10),
          themeOverride: const NodeTheme(
            fill: Colors.orange,
            stroke: Colors.purple,
            strokeWidth: 10,
          ),
        )..setTheme(
          const NodeTheme(
            fill: Colors.brown,
            stroke: Colors.blue,
            strokeWidth: 5,
          ),
        );

    final theme = node.activeThemeOverride;

    expect(theme.fill, Colors.brown);
    expect(theme.stroke, Colors.blue);
    expect(theme.strokeWidth, 5);
  });

  test('reset theme goes back to theme override', () {
    final node =
        Pump(
            id: 'A',
            position: const Position(10, 10),
            themeOverride: const NodeTheme(
              fill: Colors.orange,
              stroke: Colors.purple,
              strokeWidth: 10,
            ),
          )
          ..setTheme(
            const NodeTheme(
              fill: Colors.brown,
              stroke: Colors.blue,
              strokeWidth: 5,
            ),
          )
          ..resetTheme();

    final theme = node.activeThemeOverride;

    expect(theme.fill, Colors.orange);
    expect(theme.stroke, Colors.purple);
    expect(theme.strokeWidth, 10);
  });

  test('set part theme override', () {
    final node =
        Pump(
          id: 'A',
          position: const Position(10, 10),
          themeOverride: const NodeTheme(
            fill: Colors.orange,
            stroke: Colors.purple,
            strokeWidth: 10,
          ),
        )..setPartThemeOverride(
          0,
          const NodeTheme(
            fill: Colors.brown,
            stroke: Colors.blue,
            strokeWidth: 5,
          ),
        );

    final mainTheme = node.activeThemeOverride;
    final partTheme = node.getPartThemeOverride(0);

    expect(mainTheme.fill, Colors.orange);
    expect(mainTheme.stroke, Colors.purple);
    expect(mainTheme.strokeWidth, 10);

    expect(partTheme?.fill, Colors.brown);
    expect(partTheme?.stroke, Colors.blue);
    expect(partTheme?.strokeWidth, 5);
  });

  test('incorrect part theme index returns null theme', () {
    final node =
        Pump(
          id: 'A',
          position: const Position(10, 10),
          themeOverride: const NodeTheme(
            fill: Colors.orange,
            stroke: Colors.purple,
            strokeWidth: 10,
          ),
        )..setPartThemeOverride(
          0,
          const NodeTheme(
            fill: Colors.brown,
            stroke: Colors.blue,
            strokeWidth: 5,
          ),
        );

    final partTheme = node.getPartThemeOverride(1);
    expect(partTheme, isNull);
  });

  test('bounding box check', () {
    final node = Pump(
      id: 'A',
      position: const Position(10, 10),
      size: const Size(50, 50),
    );

    final box = node.getBoundingBox(5);

    expect(box.topLeft, const Offset(5, 5));
    expect(box.bottomRight, const Offset(60, 60));
    expect(box.topRight, const Offset(60, 5));
    expect(box.bottomLeft, const Offset(5, 60));
  });
}
