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

  test('copyWith copies only provided properties', () {
    final copied = theme.copyWith(color: Colors.purple);

    expect(copied.color, Colors.purple);
    expect(copied.fontFamily, 'Roboto');
    expect(copied.fontSize, 15);
    expect(copied.fontWeight, FontWeight.bold);
  });

  test('copyWith can replace all properties', () {
    final copied = theme.copyWith(
      color: Colors.purple,
      fontFamily: 'Apples',
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );

    expect(copied.color, Colors.purple);
    expect(copied.fontFamily, 'Apples');
    expect(copied.fontSize, 16);
    expect(copied.fontWeight, FontWeight.normal);
  });
}
