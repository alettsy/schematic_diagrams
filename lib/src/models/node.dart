import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/rendering/node_renderer.dart';

/// Base node that specifies the required properties for any node
/// to exist in the diagram.
///
/// How it looks is determined by the [renderer].
abstract class Node {
  /// Default implementation.
  Node({
    required this.id,
    required this.renderer,
    this.position = const Position(0, 0),
    this.size = const Size(32, 32),
    this.themeOverride = const NodeTheme(),
    this.rotation = 0,
  });

  /// The unique ID for this node.
  final String id;

  /// How the node will look when renderer to the screen.
  final NodeRenderer renderer;

  /// Where in the diagram the node is placed.
  final Position position;

  /// The rotation in degrees.
  final double rotation;

  /// The width and height of the node.
  final Size size;

  /// The theme that takes precedence over the inherited theme.
  final NodeTheme themeOverride;

  /// The theme that can be dynamically adjusted externally and takes
  /// precendence over all themes.
  NodeTheme? transientTheme;

  /// Get the currently active theme for this node.
  NodeTheme get activeThemeOverride => transientTheme ?? themeOverride;

  /// Targeted theme overrides for individual parts of the node.
  final Map<int, NodeTheme?> _partThemeOverrides = {};

  /// Get a part theme override for part [index].
  NodeTheme? getPartThemeOverride(int index) {
    return _partThemeOverrides[index];
  }

  /// Set a part [theme] override for part [index].
  void setPartThemeOverride(int index, NodeTheme? theme) {
    _partThemeOverrides[index] = theme;
  }

  /// Get the maximum X position of this node.
  double get maxX => position.x + size.width;

  /// Get the maximum Y position of this node.
  double get maxY => position.y + size.height;

  /// Get the bounding box of this node.
  Rect getBoundingBox(double gap) {
    return Rect.fromLTWH(
      position.x - gap,
      position.y - gap,
      size.width + gap,
      size.height + gap,
    );
  }

  /// Whether or not this node is above the [other] node, by at
  /// least the [offset].
  bool isAbove(Node other, {double offset = 0.0}) {
    return maxY + offset < other.position.y;
  }

  /// Whether or not this node is below the [other] node, by at
  /// least the [offset].
  bool isBelow(Node other, {double offset = 0.0}) {
    return other.maxY + offset < position.y;
  }

  /// Whether or not this node is left of the [other] node, by at
  /// least the [offset].
  bool isLeftOf(Node other, {double offset = 0.0}) {
    return maxX + offset < other.position.x;
  }

  /// Whether or not this node is right of the [other] node, by at
  /// least the [offset].
  bool isRightOf(Node other, {double offset = 0.0}) {
    return other.maxX + offset < position.x;
  }
}
