import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/src/core/core.dart';

void main() {
  test('LinkTheme can update all properties from copyWith', () {
    const original = LinkTheme(stroke: Colors.orange, strokeWidth: 1);
    final copied = original.copyWith(stroke: Colors.purple, strokeWidth: 4);

    expect(copied.stroke, Colors.purple);
    expect(copied.strokeWidth, 4);
  });

  test('LinkTheme updates only provided properties from copyWith', () {
    const original = LinkTheme(stroke: Colors.orange, strokeWidth: 1);
    final copied1 = original.copyWith(stroke: Colors.purple);

    expect(copied1.stroke, Colors.purple);
    expect(copied1.strokeWidth, 1);

    final copied2 = original.copyWith(strokeWidth: 4);

    expect(copied2.stroke, Colors.orange);
    expect(copied2.strokeWidth, 4);
  });

  test('LinkTheme with matching properties is equal', () {
    const first = LinkTheme(stroke: Colors.orange, strokeWidth: 1);
    const second = LinkTheme(stroke: Colors.orange, strokeWidth: 1);

    expect(first, second);
  });

  test('LinkTheme with mismatched properties is not equal', () {
    const first = LinkTheme(stroke: Colors.orange, strokeWidth: 1);
    
    const second1 = LinkTheme(stroke: Colors.orange, strokeWidth: 2);

    expect(first, isNot(second1));

    const second2 = LinkTheme(stroke: Colors.purple, strokeWidth: 1);

    expect(first, isNot(second2));
  });
}
