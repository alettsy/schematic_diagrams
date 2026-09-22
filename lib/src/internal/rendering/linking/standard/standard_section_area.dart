import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/internal/models/lines/line.dart';
import 'package:schematic_diagrams/src/internal/models/lines/straight_line.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_area.dart';

/// Standard section area, which contains all [lines] that go through it
/// from [from] to [to].
class StandardSectionArea implements SectionArea {
  /// Default implementation.
  StandardSectionArea({required this.from, required this.to});

  /// Where the section area starts [from].
  final Position from;

  /// Where the section area spans [to].
  final Position to;

  /// All lines contained in this section area.
  final List<StraightLine> lines = [];

  @override
  void addLine(Line line) {
    if (line is! StraightLine) return;

    final foundIndex = lines.indexWhere((l) => l.id == line.id);

    if (foundIndex == -1) {
      lines.add(line);
    } else {
      lines[foundIndex] = line;
    }
  }

  @override
  void removeLineById(String id) {
    lines.removeWhere((l) => l.id == id);
  }

  @override
  bool shouldContainLine(Line line) {
    if (line is! StraightLine) return false;

    var tMin = 0.0;
    var tMax = 1.0;

    final dx = line.to.x - line.from.x;
    final dy = line.to.y - line.from.y;

    for (var i = 0; i < 2; i++) {
      double p;
      double q;
      if (i == 0) {
        p = -dx;
        q = line.from.x - from.x;
      } else {
        p = dx;
        q = to.x - line.from.x;
      }

      if (p == 0 && q < 0) return false;

      final r = q / p;
      if (p < 0) {
        if (r > tMax) return false;
        if (r > tMin) tMin = r;
      } else if (p > 0) {
        if (r < tMin) return false;
        if (r < tMax) tMax = r;
      }
    }

    for (var i = 0; i < 2; i++) {
      double p;
      double q;
      if (i == 0) {
        p = -dy;
        q = line.from.y - from.y;
      } else {
        p = dy;
        q = to.y - line.from.y;
      }

      if (p == 0 && q < 0) return false;

      final r = q / p;
      if (p < 0) {
        if (r > tMax) return false;
        if (r > tMin) tMin = r;
      } else if (p > 0) {
        if (r < tMin) return false;
        if (r < tMax) tMax = r;
      }
    }

    return tMin <= tMax;
  }

  @override
  List<Position> lineIntersectsAt(Line line) {
    if (line is! StraightLine) return [];

    final intersectingPoints = <Position>[];

    for (final l in lines) {
      final intersection = l.getIntersectionWith(line);

      if (intersection != null) {
        intersectingPoints.add(intersection);
      }
    }

    return intersectingPoints;
  }

  @override
  Set<StraightLine> linesCoincideWith(Line line) {
    if (line is! StraightLine) return {};

    final overlappingLines = <StraightLine>{};

    for (final l in lines) {
      if (l.id == line.id) {
        continue;
      }

      if (l.isCoincidentWith(line)) {
        overlappingLines.add(l);
      }
    }

    return overlappingLines;
  }
}
