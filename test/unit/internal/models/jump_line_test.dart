import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';
import 'package:schematic_diagrams/src/internal/models/models.dart';

void main() {
  test('horizontal jump line returns true', () {
    final line = JumpLine(
      from: const Position(10, 10),
      to: const Position(50, 10),
      overlapHeight: 2,
    );

    expect(line.horizontal, isTrue);
  });

  test('non-horizontal jump line returns false', () {
    final line = JumpLine(
      from: const Position(10, 10),
      to: const Position(50, 11),
      overlapHeight: 2,
    );

    expect(line.horizontal, isFalse);
  });
}
