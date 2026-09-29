import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:uuid/v4.dart';

/// Base line used for link routing.
class Line {
  /// [Line] that spans [from] to [to].
  Line({required this.from, required this.to}) : id = const UuidV4().generate();

  /// Set [from] and [to] of line with provided [id]. Internal use only.
  Line.internal({required this.from, required this.to, required this.id});

  /// The unique ID for this line.
  final String id;

  /// Where this line starts.
  final Position from;

  /// Where this line goes to.
  final Position to;

  /// Whether or not the [from] and [to] points of this line
  /// are near the [position].
  bool fromOrToNearPosition(Position position) {
    return from.isNear(position) || to.isNear(position);
  }
}
