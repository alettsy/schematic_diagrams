import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/src/core/helpers/angle_helper.dart';

void main() {
  test('converts 0 degrees to 0 radians', () {
    expect(0.0.radians, 0.0);
  });

  test('converts 90 degrees to pi/2 radians', () {
    expect(90.0.radians, closeTo(pi / 2, 0.0001));
  });

  test('converts 180 degrees to pi radians', () {
    expect(180.0.radians, closeTo(pi, 0.0001));
  });

  test('converts negative degrees', () {
    expect((-90.0).radians, closeTo(-pi / 2, 0.0001));
  });
}
