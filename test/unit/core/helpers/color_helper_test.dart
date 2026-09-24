import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/src/core/helpers/color_helper.dart';

void main() {
  test('converts pure red to hex', () {
    const color = Color(0xFFFF0000);
    expect(color.hex, '#ff0000ff');
  });

  test('converts pure green to hex', () {
    const color = Color(0xFF00FF00);
    expect(color.hex, '#00ff00ff');
  });

  test('converts pure blue to hex', () {
    const color = Color(0xFF0000FF);
    expect(color.hex, '#0000ffff');
  });

  test('converts white to hex', () {
    const color = Color(0xFFFFFFFF);
    expect(color.hex, '#ffffffff');
  });

  test('converts black to hex', () {
    const color = Color(0xFF000000);
    expect(color.hex, '#000000ff');
  });

  test('converts color with alpha transparency', () {
    const color = Color(0x80FF0000); // 50% transparent red
    expect(color.hex, '#ff000080');
  });

  test('converts fully transparent color', () {
    const color = Color(0x00FFFFFF);
    expect(color.hex, '#ffffff00');
  });

  test('converts mixed color', () {
    const color = Color(0xFFABCDEF);
    expect(color.hex, '#abcdefff');
  });
}
