import 'dart:math';

import 'package:schematic_diagrams/src/internal/constants.dart';
import 'package:schematic_diagrams/src/internal/models/lines/straight_line.dart';
import 'package:schematic_diagrams/src/internal/models/link_details.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/bottom_to_top.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/left_to_bottom.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/right_to_bottom.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_path.dart';

/// Standard link router for links starting from the bottom (down) direction.
class StandardBottomRouter extends StandardLinkRouter
    with BottomToTop, LeftToBottom, RightToBottom {
  @override
  List<StraightLine> toLeft(LinkDetails linkDetails) {
    return leftToBottom(linkDetails.flip()).lines;
  }

  @override
  List<StraightLine> toTop(LinkDetails linkDetails) {
    return bottomToTop(linkDetails).lines;
  }

  @override
  List<StraightLine> toRight(LinkDetails linkDetails) {
    return rightToBottom(linkDetails.flip()).lines;
  }

  @override
  List<StraightLine> toBottom(LinkDetails linkDetails) {
    var linkPath = StandardLinkPath(start: linkDetails.fromPortPosition);

    final isLeftOfFrom = linkDetails.toNode.isLeftOf(
      linkDetails.fromNode,
      offset: standardMinSeparation,
    );
    final isRightOfFrom = linkDetails.toNode.isRightOf(
      linkDetails.fromNode,
      offset: standardMinSeparation,
    );

    if (isLeftOfFrom || isRightOfFrom) {
      linkPath = _handleLeftOrRight(linkPath, linkDetails);
    } else if (linkDetails.toNode.isBelow(
      linkDetails.fromNode,
      offset: standardMinSeparation,
    )) {
      linkPath = _handleBelow(linkPath, linkDetails);
    } else {
      linkPath = _handleAbove(linkPath, linkDetails);
    }

    linkPath.addLineTo(
      linkDetails.toPortPosition.x,
      linkDetails.toPortPosition.y,
    );
    return linkPath.lines;
  }

  StandardLinkPath _handleBelow(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final fromMaxY = linkDetails.fromNode.maxY;
    final toMaxY = linkDetails.toNode.maxY;
    final midY = (fromMaxY + linkDetails.toNode.position.y) / 2;

    linkPath
      ..addLineTo(linkDetails.fromPortPosition.x, midY)
      ..addLineTo(linkDetails.fromNode.position.x - standardMinSeparation, midY)
      ..addLineTo(
        linkDetails.fromNode.position.x - standardMinSeparation,
        toMaxY + standardMinSeparation,
      )
      ..addLineTo(linkDetails.toPortPosition.x, toMaxY + standardMinSeparation);

    return linkPath;
  }

  StandardLinkPath _handleLeftOrRight(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final drawOutY = max(
      linkDetails.toNode.maxY + standardMinSeparation,
      linkDetails.fromNode.maxY + standardMinSeparation,
    );

    linkPath
      ..addLineTo(linkDetails.fromPortPosition.x, drawOutY)
      ..addLineTo(linkDetails.toPortPosition.x, drawOutY);

    return linkPath;
  }

  StandardLinkPath _handleAbove(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final toMaxY = linkDetails.toNode.maxY;
    final midY = (toMaxY + linkDetails.fromNode.position.y) / 2;

    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x,
        linkDetails.fromPortPosition.y + standardMinSeparation,
      )
      ..addLineTo(
        linkDetails.fromNode.position.x - standardMinSeparation,
        linkDetails.fromPortPosition.y + standardMinSeparation,
      )
      ..addLineTo(linkDetails.fromNode.position.x - standardMinSeparation, midY)
      ..addLineTo(linkDetails.toPortPosition.x, midY);

    return linkPath;
  }
}
