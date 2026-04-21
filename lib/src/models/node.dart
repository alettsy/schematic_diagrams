import 'package:flutter/material.dart';

import '../core/parts/parts.dart';
import '../rendering/node_renderer.dart';

abstract class Node {
  Node({
    required this.id,
    required this.renderer,
    this.position = const Position(0, 0),
    this.size = const Size(64, 64),
    this.themeOverride = const NodeTheme(),
    this.rotation = 0,
  });

  final String id;
  final NodeRenderer renderer;
  final Position position;
  final double rotation;
  final Size size;
  final NodeTheme themeOverride;
  NodeTheme? transientTheme;

  NodeTheme get activeThemeOverride => transientTheme ?? themeOverride;

  double get rightPosition => position.x + size.width;

  double get bottomPosition => position.y + size.height;

  Rect getBoundingBox(double gap) {
    return Rect.fromLTWH(
      position.x - gap,
      position.y - gap,
      size.width + gap,
      size.height + gap,
    );
  }
}
