import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/internal/models/lines/straight_line.dart';

/// Standard link path, which is a series of straight lines.
class StandardLinkPath {
  /// Default implementation.
  StandardLinkPath({required this.start});

  /// Where the path starts.
  final Position start;

  /// The straight lines in the path.
  final lines = <StraightLine>[];

  /// Add a straight line to the coordinates [x] and [y], starting
  /// from the last added line or [start].
  void addLineTo(double x, double y) {
    lines.add(
      StraightLine(from: lines.lastOrNull?.to ?? start, to: Position(x, y)),
    );
  }
}
