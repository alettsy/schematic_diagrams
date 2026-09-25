import 'package:schematic_diagrams/src/internal/constants.dart';
import 'package:schematic_diagrams/src/internal/models/lines/line.dart';

/// A line that jumps over another.
class JumpLine extends Line {
  /// [JumpLine] that spans [from] to [to] and has a jump
  /// height of [overlapHeight].
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
