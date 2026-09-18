import 'package:flutter/foundation.dart';
import 'package:schematic_diagrams/core/parts/position.dart';

/// A place on a node where links can be connected to.
@immutable
class Port {
  /// Default implementation.
  const Port({required this.id, this.position = const Position(0, 0)});

  /// The unique [id] of the port.
  final String id;

  /// The position of the port, relative to its parent node.
  final Position position;
}
