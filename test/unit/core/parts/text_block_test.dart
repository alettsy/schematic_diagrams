import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/src/core/core.dart';

void main() {
  const theme = TextBlockTheme(
    color: Colors.orange,
    fontFamily: 'Roboto',
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  final textBlock = TextBlock(
    id: 'A',
    text: 'B',
    drawWidth: 120,
    position: const Position(10, 10),
    rotation: 90,
    textAlign: TextAlign.right,
    themeOverride: theme,
  );

  test('copyWith copies only provided properties', () {
    final copied = textBlock.copyWith(text: 'C');

    expect(copied.id, 'A');
    expect(copied.text, 'C');
    expect(copied.drawWidth, 120);
    expect(copied.position, const Position(10, 10));
    expect(copied.rotation, 90);
    expect(copied.textAlign, TextAlign.right);
    expect(copied.themeOverride, theme);
  });

  test('copyWith can replace all properties', () {
    final copied = textBlock.copyWith(
      text: 'C',
      drawWidth: 150,
      position: const Position(10, 20),
      rotation: 0,
      textAlign: TextAlign.left,
      themeOverride: theme.copyWith(color: Colors.purple),
    );

    expect(copied.id, 'A');
    expect(copied.text, 'C');
    expect(copied.drawWidth, 150);
    expect(copied.position, const Position(10, 20));
    expect(copied.rotation, 0);
    expect(copied.textAlign, TextAlign.left);
    expect(copied.themeOverride, theme.copyWith(color: Colors.purple));
  });
}
