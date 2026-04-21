import 'package:flutter/widgets.dart';

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
}
