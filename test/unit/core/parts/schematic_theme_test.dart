import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/src/core/core.dart';

void main() {
  test('SchematicTheme with matching properties is equal', () {
    final first = SchematicTheme(
      backgroundColor: Colors.brown,
      borderColor: Colors.orange,
      borderWidth: 1,
      borderRadius: BorderRadius.circular(1),
    );
    final second = SchematicTheme(
      backgroundColor: Colors.brown,
      borderColor: Colors.orange,
      borderWidth: 1,
      borderRadius: BorderRadius.circular(1),
    );

    expect(first, second);
  });

  test('SchematicTheme with mismatched properties is not equal', () {
    final first = SchematicTheme(
      backgroundColor: Colors.brown,
      borderColor: Colors.orange,
      borderWidth: 1,
      borderRadius: BorderRadius.circular(1),
    );

    final second1 = SchematicTheme(
      backgroundColor: Colors.brown,
      borderColor: Colors.orange,
      borderWidth: 3,
      borderRadius: BorderRadius.circular(1),
    );

    expect(first, isNot(second1));

    final second2 = SchematicTheme(
      backgroundColor: Colors.brown,
      borderColor: Colors.purple,
      borderWidth: 1,
      borderRadius: BorderRadius.circular(1),
    );

    expect(first, isNot(second2));

    final second3 = SchematicTheme(
      backgroundColor: Colors.blue,
      borderColor: Colors.orange,
      borderWidth: 1,
      borderRadius: BorderRadius.circular(1),
    );

    expect(first, isNot(second3));

    final second4 = SchematicTheme(
      backgroundColor: Colors.blue,
      borderColor: Colors.orange,
      borderWidth: 1,
      borderRadius: BorderRadius.circular(4),
    );

    expect(first, isNot(second4));
  });
}
