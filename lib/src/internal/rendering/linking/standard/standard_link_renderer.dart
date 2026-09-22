import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/internal/models/models.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_path_strategy.dart';
import 'package:schematic_diagrams/src/models/link.dart';
import 'package:schematic_diagrams/src/rendering/linking/link_renderer.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_manager.dart';

/// Standard link renderer, which draws straight lines and jumps at
/// intersecting lines.
class StandardLinkRenderer<T extends Link> extends LinkRenderer<T> {
  /// Default implementation.
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

    final path = Path()..moveTo(lines.first.from.x, lines.first.from.y);

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
