import 'package:schematic_diagrams/src/core/constants.dart';
import 'package:schematic_diagrams/src/models/lines/line.dart';

class JumpLine extends Line {
  JumpLine({
    required super.from,
    required super.to,
    required this.overlapHeight,
  });

  final double overlapHeight;

  bool get horizontal => (from.y - to.y).abs() <= tolerance;
}
