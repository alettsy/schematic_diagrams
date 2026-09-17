import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/models.dart';

class LinkDetails {
  LinkDetails({
    required this.outTo,
    required this.inFrom,
    required this.fromPortPosition,
    required this.toPortPosition,
    required this.fromNode,
    required this.toNode,
  });

  final LinkDirection outTo;
  final LinkDirection inFrom;
  final Position fromPortPosition;
  final Position toPortPosition;
  final Node fromNode;
  final Node toNode;

  LinkDetails flip() {
    return LinkDetails(
      outTo: inFrom,
      inFrom: outTo,
      fromPortPosition: toPortPosition,
      toPortPosition: fromPortPosition,
      fromNode: toNode,
      toNode: fromNode,
    );
  }
}
