import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

void main() {
  test('Positions can be added', () {
    const position1 = Position(10, 12);
    const position2 = Position(4, 1);

    final result = position1 + position2;

    expect(result, const Position(14, 13));
  });

  test('Positions can divide by a number', () {
    const position1 = Position(10, 12);

    final result = position1 / 2;

    expect(result, const Position(5, 6));
  });

  test('isNear returns true if positions are very close', () {
    const position1 = Position(10, 12);
    const position2 = Position(10.0000000001, 12.0000000001);

    expect(position1.isNear(position2), isTrue);
  });

  test('isNear returns false if positions are not very close', () {
    const position1 = Position(10, 12);
    const position2 = Position(11, 13);

    expect(position1.isNear(position2), isFalse);
  });
}
