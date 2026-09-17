import 'dart:math';

import 'package:schematic_diagrams/src/core/constants.dart';
import 'package:schematic_diagrams/src/models/lines/line.dart';

import '../../core/parts/parts.dart';

class StraightLine extends Line {
  StraightLine({required super.from, required super.to, super.id});

  bool get horizontal => (from.y - to.y).abs() <= tolerance;

  bool get vertical => (from.x - to.x).abs() <= tolerance;

  bool get leftToRight => !vertical && from.x < to.x;

  bool get topToBottom => !horizontal && from.y < to.y;

  bool overlapsWith(StraightLine line) {
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

  Position? getIntersectionsWith(StraightLine other) {
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

    if (isPointOnSegment(intersectionPoint, this) &&
        isPointOnSegment(intersectionPoint, other)) {
      if (fromOrToNearPosition(intersectionPoint) ||
          other.fromOrToNearPosition(intersectionPoint)) {
        return null;
      }

      return intersectionPoint;
    }

    return null;
  }

  bool isPointOnSegment(Position point, Line line) {
    return (point.x >= line.from.x && point.x <= line.to.x ||
            point.x >= line.to.x && point.x <= line.from.x) &&
        (point.y >= line.from.y && point.y <= line.to.y ||
            point.y >= line.to.y && point.y <= line.from.y);
  }

  StraightLine flip() {
    return StraightLine(from: to, to: from, id: id);
  }

  StraightLine copyWith({Position? to, Position? from}) {
    return StraightLine(to: to ?? this.to, from: from ?? this.from, id: id);
  }
}
