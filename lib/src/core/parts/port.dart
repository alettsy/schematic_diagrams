import 'package:flutter/foundation.dart';
import 'package:schematic_diagrams/src/core/parts/position.dart';
import 'package:schematic_diagrams/src/internal/base/id_based.dart';

/// A place on a node where links can be connected to.
@immutable
class Port implements IdBased {
  /// Default implementation.
  const Port({required this.id, this.position = const Position(0, 0)});

  /// The unique [id] of the port.
  @override
  final String id;

  /// The position of the port, relative to its parent node.
  final Position position;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Port) return false;

    return id == other.id && position == other.position;
  }

  @override
  int get hashCode => Object.hash(id, position);
}
