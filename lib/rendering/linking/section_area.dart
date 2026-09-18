import 'package:schematic_diagrams/core/parts/position.dart';
import 'package:schematic_diagrams/src/models/lines/line.dart';

/// The area on the diagram which a line occupies.
abstract class SectionArea {
  /// Add [line] to the section area.
  void addLine(Line line);

  /// Remove line by its ID from the section area.
  void removeLineById(String id);

  /// Whether or not this section should contain [line].
  bool shouldContainLine(Line line);

  /// Get all positions that [line] intersects other lines at in this
  /// section.
  List<Position> lineIntersectsAt(Line line);

  /// Get all lines that coincide with [line] in this section.
  Set<Line> linesCoincideWith(Line line);
}
