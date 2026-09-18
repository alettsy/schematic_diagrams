import 'package:schematic_diagrams/src/constants.dart';
import 'package:schematic_diagrams/src/models/lines/line.dart';

/// A line that jumps over another.
class JumpLine extends Line {
  /// Default implementation.
  JumpLine({
    required super.from,
    required super.to,
    required this.overlapHeight,
  });

  /// How high the jump should be.
  final double overlapHeight;

  /// Whether or not this line is moving horizontally.
  bool get horizontal => (from.y - to.y).abs() <= tolerance;
}
