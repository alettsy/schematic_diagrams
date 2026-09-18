import 'package:schematic_diagrams/core/parts/link_direction.dart';
import 'package:schematic_diagrams/src/models/lines/straight_line.dart';
import 'package:schematic_diagrams/src/models/link_details.dart';

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
