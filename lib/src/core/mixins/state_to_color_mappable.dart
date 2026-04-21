import 'dart:ui';

import '../../models/node.dart';
import 'updatable.dart';
import 'valuable.dart';

mixin StateToColorMappable<T> on Updatable, Valuable<T>, Node {
  Map<T, Color>? stateColorMap;

  // TODO: real implementation
  Color? get colorFromState {
    for (final stateValue in stateColorMap?.keys ?? []) {
      if (stateValue == value) {
        return stateColorMap![stateValue];
      }
    }

    return null;
  }
}
