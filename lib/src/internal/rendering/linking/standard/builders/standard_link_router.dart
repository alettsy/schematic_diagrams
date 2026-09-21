import 'package:schematic_diagrams/src/core/parts/link_direction.dart';
import 'package:schematic_diagrams/src/internal/models/link_details.dart';
import 'package:schematic_diagrams/src/internal/models/lines/straight_line.dart';

const double minDistanceFromNodes = 5;

abstract class StandardLinkRouter {
  List<StraightLine> toTop(LinkDetails linkDetails);
  List<StraightLine> toBottom(LinkDetails linkDetails);
  List<StraightLine> toLeft(LinkDetails linkDetails);
  List<StraightLine> toRight(LinkDetails linkDetails);

  List<StraightLine> getLines(LinkDetails linkDetails) {
    switch (linkDetails.inFrom) {
      case LinkDirection.left:
        return toLeft(linkDetails);
      case LinkDirection.right:
        return toRight(linkDetails);
      case LinkDirection.up:
        return toTop(linkDetails);
      case LinkDirection.down:
        return toBottom(linkDetails);
    }
  }
}
