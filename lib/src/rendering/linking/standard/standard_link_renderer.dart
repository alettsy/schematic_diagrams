import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/lines/jump_line.dart';
import 'package:schematic_diagrams/src/models/lines/straight_line.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_manager.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_link_path_strategy.dart';

import '../../../models/link.dart';
import '../../../models/node_resolver.dart';
import '../link_renderer.dart';

class StandardLinkRenderer<T extends Link> extends LinkRenderer<T> {
  StandardLinkRenderer({required SectionManager sectionManager})
    : super(
        pathStrategy: StandardLinkPathStrategy(sectionManager: sectionManager),
      );

  @override
  void paint(
    Canvas canvas,
    Link link,
    NodeResolver nodeResolver,
    LinkTheme defaultLinkTheme,
  ) {
    final paint = Paint()
      ..color =
          link.activeTheme.stroke ??
          defaultLinkTheme.stroke ??
          Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          link.activeTheme.strokeWidth ?? defaultLinkTheme.strokeWidth ?? 0;

    final lines = pathStrategy.compute(link, nodeResolver);
    if (lines.isEmpty) return;

    final path = Path();
    path.moveTo(lines.first.from.x, lines.first.from.y);

    for (final line in lines) {
      if (line is JumpLine) {
        Position curvePoint;

        if (line.horizontal) {
          curvePoint = Position(
            (line.from.x + line.to.x) / 2,
            line.from.y - line.overlapHeight,
          );
        } else {
          curvePoint = Position(
            line.from.x + line.overlapHeight,
            (line.from.y + line.to.y) / 2,
          );
        }

        path.quadraticBezierTo(
          curvePoint.x,
          curvePoint.y,
          line.to.x,
          line.to.y,
        );
      } else if (line is StraightLine) {
        path.lineTo(line.to.x, line.to.y);
      }
    }

    canvas.drawPath(path, paint);
  }
}
