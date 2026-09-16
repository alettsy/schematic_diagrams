import 'package:schematic_diagrams/src/core/parts/link_direction.dart';
import 'package:schematic_diagrams/src/models/lines/line.dart';
import 'package:schematic_diagrams/src/models/link_details.dart';

const double minDistanceFromNodes = 5;

abstract class StandardLinkRouter {
  List<Line> toTop(LinkDetails linkDetails);
  List<Line> toBottom(LinkDetails linkDetails);
  List<Line> toLeft(LinkDetails linkDetails);
  List<Line> toRight(LinkDetails linkDetails);

  List<Line> getLines(LinkDetails linkDetails) {
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
