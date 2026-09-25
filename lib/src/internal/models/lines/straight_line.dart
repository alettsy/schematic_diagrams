import 'dart:math';

import 'package:schematic_diagrams/src/core/parts/position.dart';
import 'package:schematic_diagrams/src/internal/constants.dart';
import 'package:schematic_diagrams/src/internal/models/lines/line.dart';

/// A straight horizontal or vertical line.
///
/// Used in the standard link router.
class StraightLine extends Line {
  /// [StraightLine] that spans [from] to [to].
  /// 
  /// Can only be horizontal or vertical.
  StraightLine({required super.from, required super.to, super.id});

  /// Whether or not this line is moving horizontally.
  bool get horizontal => (from.y - to.y).abs() <= tolerance;

  /// Whether or not this line is moving vertically.
  bool get vertical => (from.x - to.x).abs() <= tolerance;

  /// Whether or not this line is moving from left to right.
  bool get leftToRight => !vertical && from.x < to.x;

  /// Whether or not this line is moving from top to bottom.
  bool get topToBottom => !horizontal && from.y < to.y;

  /// Whether or not this line is coincident with [line].
  bool isCoincidentWith(StraightLine line) {
    if (line.horizontal && horizontal) {
      if ((line.from.y - from.y).abs() > tolerance) {
        return false;
      }

      final aMinX = min(from.x, to.x);
      final aMaxX = max(from.x, to.x);
      final bMinX = min(line.from.x, line.to.x);
      final bMaxX = max(line.from.x, line.to.x);

      return aMinX <= (bMaxX + tolerance) && bMinX <= (aMaxX + tolerance);
    }

    if (line.vertical && vertical) {
      if ((line.from.x - from.x).abs() > tolerance) {
        return false;
      }

      final aMinY = min(from.y, to.y);
      final aMaxY = max(from.y, to.y);
      final bMinY = min(line.from.y, line.to.y);
      final bMaxY = max(line.from.y, line.to.y);

      return aMinY <= (bMaxY + tolerance) && bMinY <= (aMaxY + tolerance);
    }

    return false;
  }

  /// The position where this line intersections with the [other] line, if any.
  Position? getIntersectionWith(StraightLine other) {
    final x1 = from.x;
    final y1 = from.y;
    final x2 = to.x;
    final y2 = to.y;

    final x3 = other.from.x;
    final y3 = other.from.y;
    final x4 = other.to.x;
    final y4 = other.to.y;

    final denominator = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);

    if (denominator.abs() < tolerance) {
      return null;
    }

    final intersectionX =
        ((x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)) /
        denominator;
    final intersectionY =
        ((x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)) /
        denominator;

    final intersectionPoint = Position(intersectionX, intersectionY);

    if (_isPointOnSegment(intersectionPoint, this) &&
        _isPointOnSegment(intersectionPoint, other)) {
      if (fromOrToNearPosition(intersectionPoint) ||
          other.fromOrToNearPosition(intersectionPoint)) {
        return null;
      }

      return intersectionPoint;
    }

    return null;
  }

  bool _isPointOnSegment(Position point, Line line) {
    return (point.x >= line.from.x && point.x <= line.to.x ||
            point.x >= line.to.x && point.x <= line.from.x) &&
        (point.y >= line.from.y && point.y <= line.to.y ||
            point.y >= line.to.y && point.y <= line.from.y);
  }

  /// Flip this line, so the from and to are switched.
  StraightLine flip() {
    return StraightLine(from: to, to: from, id: id);
  }

  /// Copy this line with new properties.
  StraightLine copyWith({Position? to, Position? from}) {
    return StraightLine(to: to ?? this.to, from: from ?? this.from, id: id);
  }
}
