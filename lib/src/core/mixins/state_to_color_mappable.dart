import 'dart:ui';

import 'package:schematic_diagrams/src/core/mixins/updatable.dart';
import 'package:schematic_diagrams/src/core/mixins/valuable.dart';
import 'package:schematic_diagrams/src/models/node.dart';

/// Allows nodes to adapt their color to state.
mixin StateToColorMappable<T> on Updatable, Valuable<T>, Node {
  /// Mapping of states to colors.
  Map<T, Color>? stateColorMap;

  /// Get the color to use for the node based on its state.
  Color? get colorFromState {
    for (final stateValue in stateColorMap?.keys ?? []) {
      if (stateValue == value) {
        return stateColorMap![stateValue];
      }
    }

    return null;
  }
}
