import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:uuid/v4.dart';

abstract class Line {
  Line({String? id, required this.from, required this.to})
    : id = id ?? UuidV4().generate();

  final String id;
  final Position from;
  final Position to;

  bool fromOrToNearPosition(Position position) {
    return from.isNear(position) || to.isNear(position);
  }
}
