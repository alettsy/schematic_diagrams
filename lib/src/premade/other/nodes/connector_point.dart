import 'dart:ui';

import 'package:schematic_diagrams/src/core/mixins/mixins.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/rendering/standard/designless_renderer.dart';

/// Invisible point to allow for manual adjustments to link
/// routing.
class ConnectorPoint extends Node with Linkable {
  /// Default implementation.
  ConnectorPoint({required super.id, super.position})
    : super(renderer: DesignlessRenderer(), size: const Size(1, 1)) {
    ports = ProtectedList([const Port(id: 'point')]);
  }
}
