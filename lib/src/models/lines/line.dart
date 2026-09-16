import 'package:schematic_diagrams/src/core/parts/parts.dart';

abstract class Line {
  Line({required this.from, required this.to});

  final Position from;
  final Position to;
}
