import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/internal/models/lines/line.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_area.dart';

/// Base manager for tracking where links go on the diagram by partitioning,
/// so evaluating interactions with other links is more efficient.
abstract interface class SectionManager {
  /// Clear all sections.
  void clear();

  /// Add a line to the appropriate sections.
  void addLine(Line line);

  /// Remove a line from its related sections.
  void removeLine(Line line);

  /// Remove a line by ID from its related sections.
  void removeLineById(String id);

  /// Get all lines that coincide with [line], excluding any lines
  /// found in [excludeLines].
  Set<Line> getAllCoincidingLines(
    Line line, {
    List<Line> excludeLines = const [],
  });

  /// Get all points where [line] intersects with other lines in the
  /// sections that it occupies.
  List<Position> getAllIntersectionPoints(Line line);

  /// Get all sections that the [line] occupies.
  List<SectionArea> getSectionAreasForLine(Line line);
}
