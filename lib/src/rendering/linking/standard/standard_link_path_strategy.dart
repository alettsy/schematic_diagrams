import 'package:schematic_diagrams/schematic_diagrams.dart';
import 'package:schematic_diagrams/src/models/lines/jump_line.dart';
import 'package:schematic_diagrams/src/models/lines/line.dart';
import 'package:schematic_diagrams/src/models/lines/straight_line.dart';
import 'package:schematic_diagrams/src/models/link_details.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_bottom_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_left_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_right_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_top_router.dart';

import '../../../models/node_resolver.dart';
import '../link_path_strategy.dart';

class StandardLinkPathStrategy<T extends Link> extends LinkPathStrategy<T> {
  StandardLinkPathStrategy({
    required super.sectionManager,
    this.gap = 8,
    this.overlapHeight = 10,
    this.linkShiftSize = 8,
    this.maxShiftAttempts = 10,
  });

  final double gap;
  final double overlapHeight;
  final double linkShiftSize;
  final int maxShiftAttempts;

  @override
  List<Line> compute(T link, NodeResolver nodeResolver) {
    final fromNode = nodeResolver.getNode(link.fromNodeId);
    final toNode = nodeResolver.getNode(link.toNodeId);

    if (fromNode is! Linkable || toNode is! Linkable) {
      return [];
    }

    final fromPortOffset = fromNode.getPortOffset(link.fromPortId);
    final toPortOffset = toNode.getPortOffset(link.toPortId);

    if (fromPortOffset == null || toPortOffset == null) {
      return [];
    }

    final initialPath = _computeLinkPath(
      LinkDetails(
        outTo: link.outTo,
        inFrom: link.inFrom,
        fromPortPosition: fromPortOffset,
        toPortPosition: toPortOffset,
        fromNode: fromNode,
        toNode: toNode,
      ),
    );

    initialPath.forEach(sectionManager.addLine);

    final adjustedForParallelOverlap = _repositionLinesToAvoidOverlap(
      initialPath,
    );

    final withOverlaps = _injectOverlapLines(adjustedForParallelOverlap);

    // print(withOverlaps.length);

    // if (withOverlaps.last.to != toPortOffset) {
    //   withOverlaps.add(
    //     StraightLine(from: withOverlaps.last.to, to: toPortOffset),
    //   );
    //   sectionManager.addLine(withOverlaps.last);
    // }

    return withOverlaps;
  }

  List<StraightLine> _computeLinkPath(LinkDetails linkDetails) {
    switch (linkDetails.outTo) {
      case LinkDirection.left:
        return StandardLeftRouter().getLines(linkDetails);
      case LinkDirection.right:
        return StandardRightRouter().getLines(linkDetails);
      case LinkDirection.up:
        return StandardTopRouter().getLines(linkDetails);
      case LinkDirection.down:
        return StandardBottomRouter().getLines(linkDetails);
    }
  }

  List<StraightLine> _repositionLinesToAvoidOverlap(List<StraightLine> lines) {
    if (lines.length < 3) return lines;

    var shifts = 0;
    final excludedLines = [lines.first, lines.last];

    while (shifts < maxShiftAttempts) {
      final secondLine = lines[1];

      final overlappingLines = sectionManager.getAllOverlappingLines(
        secondLine,
        excludeLines: excludedLines,
      );

      if (overlappingLines.isEmpty) {
        break;
      }

      final overlapLine = overlappingLines.first;

      if (overlapLine is! StraightLine) continue;

      if (overlapLine.horizontal) {
        _shiftAllLinesUp(lines);
      } else {
        _shiftAllLinesRight(lines);
      }

      shifts += 1;
    }

    return lines;
  }

  void _shiftAllLinesUp(List<StraightLine> lines) {
    for (var i = 0; i < lines.length - 1; i++) {
      final line = lines[i];

      sectionManager.removeLine(lines[i]);

      if (line.vertical) {
        lines[i] = line.copyWith(
          to: line.to.copyWith(y: line.to.y - linkShiftSize),
        );
      } else {
        lines[i] = line.copyWith(
          to: line.to.copyWith(y: line.to.y - linkShiftSize),
          from: line.from.copyWith(y: line.from.y - linkShiftSize),
        );
      }

      sectionManager.addLine(lines[i]);
    }
  }

  void _shiftAllLinesRight(List<StraightLine> lines) {
    for (var i = 0; i < lines.length - 1; i++) {
      final line = lines[i];

      sectionManager.removeLine(lines[i]);

      if (line.vertical) {
        lines[i] = line.copyWith(
          to: line.to.copyWith(x: line.to.x + linkShiftSize),
        );
      } else {
        lines[i] = line.copyWith(
          to: line.to.copyWith(x: line.to.x + linkShiftSize),
          from: line.from.copyWith(x: line.from.x + linkShiftSize),
        );
      }

      sectionManager.addLine(lines[i]);
    }
  }

  List<Line> _injectOverlapLines(List<StraightLine> lines) {
    var newLinkPath = <Line>[];

    for (var line in lines) {
      final intersectionPoints = sectionManager.getAllIntersectionPoints(line)
        ..removeWhere((point) => point == line.to || point == line.from);

      if (intersectionPoints.isEmpty) {
        newLinkPath.add(line);
        continue;
      }

      if (line.horizontal) {
        intersectionPoints.sort((a, b) => a.x.compareTo(b.x));
      } else {
        intersectionPoints.sort((a, b) => a.y.compareTo(b.y));
      }

      sectionManager.removeLineById(line.id);

      if (line.horizontal) {
        newLinkPath = _handleHorizontalLine(
          newLinkPath,
          line,
          intersectionPoints,
        );
      } else {
        newLinkPath = _handleVerticalLine(
          newLinkPath,
          line,
          intersectionPoints,
        );
      }

      newLinkPath.add(
        StraightLine(
          from: lines.last.to,
          to: Position(line.to.x, line.to.y),
        ),
      );
      sectionManager.addLine(newLinkPath.last);
    }

    return newLinkPath;
  }

  List<Line> _handleHorizontalLine(
    List<Line> lines,
    StraightLine line,
    List<Position> intersectionPoints,
  ) {
    var localIntersections = intersectionPoints;
    final appliedOverlap = line.leftToRight ? -gap : gap;

    if (!line.leftToRight) {
      localIntersections = localIntersections.reversed.toList();
    }

    for (final point in localIntersections) {
      final endOfLine = Position(point.x + appliedOverlap, point.y);
      final endOfOverlap = Position(point.x - appliedOverlap, point.y);
      final overlap = JumpLine(
        from: endOfLine,
        to: endOfOverlap,
        overlapHeight: overlapHeight,
      );

      final jumpsTooFar = line.leftToRight
          ? line.from.x > endOfOverlap.x || endOfLine.x > line.to.x
          : line.from.x < endOfLine.x || endOfOverlap.x < line.to.x;

      if (jumpsTooFar) {
        continue;
      }

      lines.add(
        StraightLine(
          from: lines.lastOrNull?.to ?? line.from,
          to: Position(endOfLine.x, endOfLine.y),
        ),
      );
      sectionManager.addLine(lines.last);
      lines.add(overlap);
    }

    return lines;
  }

  List<Line> _handleVerticalLine(
    List<Line> lines,
    StraightLine line,
    List<Position> intersectionPoints,
  ) {
    var localIntersections = intersectionPoints;
    final appliedOverlap = line.topToBottom ? -gap : gap;

    if (!line.topToBottom) {
      localIntersections = localIntersections.reversed.toList();
    }

    for (final point in localIntersections) {
      final endOfLine = Position(point.x, point.y + appliedOverlap);
      final endOfOverlap = Position(point.x, point.y - appliedOverlap);
      final overlap = JumpLine(
        from: endOfLine,
        to: endOfOverlap,
        overlapHeight: overlapHeight,
      );

      final jumpsTooFar = line.topToBottom
          ? line.from.y > endOfOverlap.y || endOfLine.y > line.to.y
          : line.from.y < endOfLine.y || endOfOverlap.y < line.to.y;

      if (jumpsTooFar) {
        continue;
      }

      lines.add(
        StraightLine(
          from: lines.lastOrNull?.to ?? line.from,
          to: Position(endOfLine.x, endOfLine.y),
        ),
      );
      sectionManager.addLine(lines.last);
      lines.add(overlap);
    }

    return lines;
  }
}
