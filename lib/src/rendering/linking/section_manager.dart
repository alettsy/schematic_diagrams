import 'package:schematic_diagrams/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/lines/line.dart';

abstract interface class SectionManager {
  void clear();

  void addLine(Line line);

  void removeLine(Line line);

  void removeLineById(String id);

  Set<Line> getAllOverlappingLines(
    Line line, {
    List<Line> excludeLines = const [],
  });

  List<Position> getAllIntersectionPoints(Line line);
}
