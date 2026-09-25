import 'package:flutter/widgets.dart';
import 'package:schematic_diagrams/src/internal/constants.dart';

/// Representation of a Cartesian coordinate.
@immutable
class Position {
  /// Two dimensional position reperesented as [x] and [y].
  ///
  /// Can be converted to an [Offset] using `.asOffset`.
  const Position(this.x, this.y);

  /// The horizontal [x] position.
  final double x;

  /// The vertical [y] position.
  final double y;

  /// Copy this position with new properties.
  Position copyWith({double? x, double? y}) {
    return Position(x ?? this.x, y ?? this.y);
  }

  /// Convert this position to an [Offset].
  Offset get asOffset => Offset(x, y);

  /// Add this position with the [other].
  Position operator +(Position other) {
    return Position(x + other.x, y + other.y);
  }

  /// Divide this position by the [value].
  Position operator /(double value) {
    return Position(x / value, y / value);
  }

  /// Whether or not this position is near to the [other] position, within
  /// a degree of [tolerance].
  bool isNear(Position other) {
    return (x - other.x).abs() < tolerance && (y - other.y).abs() < tolerance;
  }

  @override
  String toString() {
    return '($x, $y)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Position) return false;

    return x == other.x && y == other.y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
