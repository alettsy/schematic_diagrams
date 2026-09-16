import 'package:schematic_diagrams/src/core/constants.dart';
import 'package:schematic_diagrams/src/models/lines/line.dart';

class StraightLine extends Line {
  StraightLine({required super.from, required super.to});

  bool get horizontal => (from.y - to.y).abs() <= tolerance;

  bool get vertical => (from.x - to.x).abs() <= tolerance;

  bool get leftToRight => vertical ? false : from.x < to.x;

  bool get topToBottom => horizontal ? false : from.y < to.y;
}
