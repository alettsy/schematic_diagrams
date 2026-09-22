import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/internal/models/lines/line.dart';
import 'package:schematic_diagrams/src/internal/models/lines/straight_line.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_section_area.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_area.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_manager.dart';

/// Manages the link lines in the diagram based on the areas
/// in which they intersect.
class StandardSectionManager implements SectionManager {
  /// Default implementation.
  StandardSectionManager({this.sectionSize = 100.0});

  /// The square size of each section.
  final double sectionSize;

  /// All sections in the diagram.
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
  Set<Line> getAllCoincidingLines(
    Line line, {
    List<Line> excludeLines = const [],
  }) {
    if (line is! StraightLine) return {};

    final lines = <StraightLine>{};

    final sectionAreas = getSectionAreasForLine(line);
    for (final section in sectionAreas) {
      final coincidingLines = section.linesCoincideWith(line);
      lines.addAll(coincidingLines as Set<StraightLine>);
    }

    final excludeIds = excludeLines.map((e) => e.id);
    lines.removeWhere((l) => excludeIds.contains(l.id));

    return lines;
  }

  @override
  List<SectionArea> getSectionAreasForLine(Line line) {
    if (line is! StraightLine) return [];

    if (line.vertical) {
      return _getSectionAreasForVerticalLine(line);
    } else {
      return _getSectionAreasForHorizontalLine(line);
    }
  }

  /// Get the section that spans [from] to [to], or create one
  /// if it does not exist.
  StandardSectionArea getOrAddSection(Position from, Position to) {
    return sections.firstWhere(
      (s) => s.from == from && s.to == to,
      orElse: () {
        final newSection = StandardSectionArea(from: from, to: to);
        sections.add(newSection);
        return newSection;
      },
    );
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
