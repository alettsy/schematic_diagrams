import 'package:schematic_diagrams/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/lines/line.dart';
import 'package:schematic_diagrams/src/models/lines/straight_line.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_manager.dart';

const sectionSize = 100.0;

class StandardSectionManager implements SectionManager {
  StandardSectionManager();

  List<StandardSectionArea> sections = [];

  @override
  void clear() {
    sections.clear();
  }

  @override
  void addLine(Line line) {
    if (line is! StraightLine) return;

    final sectionAreas = getSectionAreasForLine(line);
    for (final section in sectionAreas) {
      section.addLine(line);
    }
  }

  @override
  void removeLine(Line line) {
    if (line is! StraightLine) return;

    final sectionAreas = getSectionAreasForLine(line);
    for (final section in sectionAreas) {
      section.removeLineById(line.id);
    }
  }

  @override
  void removeLineById(String id) {
    for (final section in sections) {
      section.removeLineById(id);
    }
  }

  @override
  List<Position> getAllIntersectionPoints(Line line) {
    if (line is! StraightLine) return <Position>[];

    final positions = <Position>{};

    for (final section in sections) {
      positions.addAll(section.lineIntersectsAt(line));
    }

    return positions.toList();
  }

  @override
  Set<Line> getAllOverlappingLines(
    Line line, {
    List<Line> excludeLines = const [],
  }) {
    if (line is! StraightLine) return {};

    final lines = <StraightLine>{};

    final sectionAreas = getSectionAreasForLine(line);
    for (final section in sectionAreas) {
      lines.addAll(section.linesOverlapWith(line));
    }

    final excludeIds = excludeLines.map((e) => e.id);
    lines.removeWhere((l) => excludeIds.contains(l.id));

    return lines;
  }

  List<StandardSectionArea> getSectionAreasForLine(StraightLine line) {
    if (line.vertical) {
      return _getSectionAreasForVerticalLine(line);
    } else {
      return _getSectionAreasForHorizontalLine(line);
    }
  }

  StandardSectionArea getOrAddSection(Position from, Position to) {
    try {
      final found = sections.firstWhere((s) => s.from == from && s.to == to);
      return found;
    } on StateError {
      final newSection = StandardSectionArea(from: from, to: to);
      sections.add(newSection);
      return newSection;
    }
  }

  List<StandardSectionArea> _getSectionAreasForHorizontalLine(
    StraightLine line,
  ) {
    var localLine = line;
    final intersectingSections = <StandardSectionArea>[];

    if (!localLine.leftToRight) {
      localLine = localLine.flip();
    }

    final startX = (localLine.from.x ~/ sectionSize) * sectionSize;
    final endX = (localLine.to.x ~/ sectionSize) * sectionSize;

    final count = ((endX - startX) ~/ sectionSize) + 1;
    final y = (localLine.from.y ~/ sectionSize) * sectionSize;

    for (var i = 0; i < count; i++) {
      final sectionX = startX + (i * sectionSize);
      final from = Position(sectionX, y);
      final to = Position(sectionX + sectionSize, y + sectionSize);
      final section = getOrAddSection(from, to);
      intersectingSections.add(section);
    }

    return intersectingSections;
  }

  List<StandardSectionArea> _getSectionAreasForVerticalLine(StraightLine line) {
    var localLine = line;
    final intersectingSections = <StandardSectionArea>[];

    if (!localLine.topToBottom) {
      localLine = localLine.flip();
    }

    final startY = (localLine.from.y ~/ sectionSize) * sectionSize;
    final endY = (localLine.to.y ~/ sectionSize) * sectionSize;

    final count = ((endY - startY) ~/ sectionSize) + 1;
    final x = (localLine.from.x ~/ sectionSize) * sectionSize;

    for (var i = 0; i < count; i++) {
      final sectionY = startY + (i * sectionSize);
      final from = Position(x, sectionY);
      final to = Position(x + sectionSize, sectionY + sectionSize);
      final section = getOrAddSection(from, to);
      intersectingSections.add(section);
    }

    return intersectingSections;
  }
}

class StandardSectionArea {
  StandardSectionArea({required this.from, required this.to});

  final Position from;
  final Position to;
  final List<StraightLine> lines = [];

  void addLine(StraightLine line) {
    final foundIndex = lines.indexWhere((l) => l.id == line.id);

    if (foundIndex == -1) {
      lines.add(line);
    } else {
      lines[foundIndex] = line;
    }
  }

  void removeLineById(String id) {
    lines.removeWhere((l) => l.id == id);
  }

  bool shouldContainLine(StraightLine line) {
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

  List<Position> lineIntersectsAt(StraightLine line) {
    final intersectingPoints = <Position>[];

    for (final l in lines) {
      final intersection = l.getIntersectionWith(line);

      if (intersection != null) {
        intersectingPoints.add(intersection);
      }
    }

    return intersectingPoints;
  }

  Set<StraightLine> linesOverlapWith(StraightLine line) {
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! StandardSectionArea) return false;

    return from == other.from && to == other.to;
  }

  @override
  int get hashCode => Object.hash(from, to);
}
