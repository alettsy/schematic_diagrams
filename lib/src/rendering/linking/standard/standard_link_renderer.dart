import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_link_path_strategy.dart';

import '../../../core/parts/link_theme.dart';
import '../../../models/link.dart';
import '../../../models/node_resolver.dart';
import '../link_renderer.dart';

class StandardLinkRenderer<T extends Link> extends LinkRenderer<T> {
  const StandardLinkRenderer()
    : super(pathStrategy: const StandardLinkPathStrategy());

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
      // TODO: depending on type of line, draw differently
      // If line missing, skip
      path.lineTo(line.to.x, line.to.y);
    }

    canvas.drawPath(path, paint);
  }
}
