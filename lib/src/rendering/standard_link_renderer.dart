import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/rendering/standard_link_path_strategy.dart';

import '../core/parts/link_theme.dart';
import '../models/link.dart';
import '../models/node_resolver.dart';
import 'link_renderer.dart';

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

    final points = pathStrategy.compute(link, nodeResolver);
    if (points.isEmpty) return;

    final path = Path();
    path.moveTo(points.first.x, points.first.y);

    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].x, points[i].y);
    }
    canvas.drawPath(path, paint);
  }
}
