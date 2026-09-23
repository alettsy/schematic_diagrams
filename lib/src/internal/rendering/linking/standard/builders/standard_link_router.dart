import 'package:schematic_diagrams/src/core/parts/link_direction.dart';
import 'package:schematic_diagrams/src/internal/models/lines/straight_line.dart';
import 'package:schematic_diagrams/src/internal/models/link_details.dart';

/// Standard link router which requires specifying how to handle all
/// possible link directions.
abstract class StandardLinkRouter {
  /// Handle link routing to the top (up) direction.
  List<StraightLine> toTop(LinkDetails linkDetails);

  /// Handle link routing to the bottom (down) direction.
  List<StraightLine> toBottom(LinkDetails linkDetails);

  /// Handle link routing to the left direction.
  List<StraightLine> toLeft(LinkDetails linkDetails);

  /// Handle link routing to the right direction.
  List<StraightLine> toRight(LinkDetails linkDetails);

  /// Get all standard routing lines generated between the start 
  /// and end directions of [linkDetails].
  List<StraightLine> getLines(LinkDetails linkDetails) {
    switch (linkDetails.inFrom) {
      case LinkDirection.left:
        return toLeft(linkDetails);
      case LinkDirection.right:
        return toRight(linkDetails);
      case LinkDirection.top:
        return toTop(linkDetails);
      case LinkDirection.bottom:
        return toBottom(linkDetails);
    }
  }
}
