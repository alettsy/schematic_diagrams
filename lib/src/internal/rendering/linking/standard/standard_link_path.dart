import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/internal/models/lines/straight_line.dart';

class StandardLinkPath {
  StandardLinkPath({required this.start});

  final Position start;
  final lines = <StraightLine>[];

  void addLineTo(double x, double y) {
    lines.add(
      StraightLine(from: lines.lastOrNull?.to ?? start, to: Position(x, y)),
    );
  }
}
