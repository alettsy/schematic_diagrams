import 'package:flutter/widgets.dart';
import 'package:schematic_diagrams/src/core/constants.dart';

@immutable
class Position {
  const Position(this.x, this.y);

  final double x;
  final double y;

  Position copyWith({double? x, double? y}) {
    return Position(x ?? this.x, y ?? this.y);
  }

  Offset get asOffset => Offset(x, y);

  Position operator +(Position other) {
    return Position(x + other.x, y + other.y);
  }

  Position operator /(double value) {
    return Position(x / value, y / value);
  }

  bool isNear(Position other) {
    return (x - other.x).abs() < tolerance && (y - other.y).abs() < tolerance;
  }
}
