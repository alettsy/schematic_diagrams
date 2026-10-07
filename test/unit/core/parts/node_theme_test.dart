import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/src/core/core.dart';

void main() {
  test('NodeTheme can update all properties from copyWith', () {
    const original = NodeTheme(
      fill: Colors.brown,
      stroke: Colors.orange,
      strokeWidth: 1,
    );
    final copied = original.copyWith(
      fill: Colors.blue,
      stroke: Colors.purple,
      strokeWidth: 4,
    );

    expect(copied.fill, Colors.blue);
    expect(copied.stroke, Colors.purple);
    expect(copied.strokeWidth, 4);
  });

  test('NodeTheme updates only provided properties from copyWith', () {
    const original = NodeTheme(
      fill: Colors.brown,
      stroke: Colors.orange,
      strokeWidth: 1,
    );
    final copied1 = original.copyWith(stroke: Colors.purple);

    expect(copied1.fill, Colors.brown);
    expect(copied1.stroke, Colors.purple);
    expect(copied1.strokeWidth, 1);

    final copied2 = original.copyWith(strokeWidth: 4);

    expect(copied2.fill, Colors.brown);
    expect(copied2.stroke, Colors.orange);
    expect(copied2.strokeWidth, 4);

    final copied3 = original.copyWith(fill: Colors.blue);

    expect(copied3.fill, Colors.blue);
    expect(copied3.stroke, Colors.orange);
    expect(copied3.strokeWidth, 1);
  });

  test('NodeTheme with matching properties is equal', () {
    const first = NodeTheme(
      fill: Colors.brown,
      stroke: Colors.orange,
      strokeWidth: 1,
    );
    const second = NodeTheme(
      fill: Colors.brown,
      stroke: Colors.orange,
      strokeWidth: 1,
    );

    expect(first, second);
  });

  test('NodeTheme with mismatched properties is not equal', () {
    const first = NodeTheme(
      fill: Colors.brown,
      stroke: Colors.orange,
      strokeWidth: 1,
    );

    const second1 = NodeTheme(
      fill: Colors.brown,
      stroke: Colors.orange,
      strokeWidth: 2,
    );

    expect(first, isNot(second1));

    const second2 = NodeTheme(
      fill: Colors.brown,
      stroke: Colors.purple,
      strokeWidth: 1,
    );

    expect(first, isNot(second2));

    const second3 = NodeTheme(
      fill: Colors.blue,
      stroke: Colors.orange,
      strokeWidth: 1,
    );

    expect(first, isNot(second3));
  });
}
