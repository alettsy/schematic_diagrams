import 'package:flutter/material.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';
import 'package:schematic_diagrams/src/premade/pid/renderers/circular_pid_renderer.dart';

/// Toggleable node with a boolean state.
class ToggleNode extends Node
    with ChangeNotifier, Updatable, Valuable<bool>, Tappable, TextBlockable {
  /// Default implementation.
  ToggleNode({required super.id, super.position, String? title})
    : super(renderer: CircularPaintedNodeRenderer()) {
    if (title != null) {
      textBlocks.add(
        TextBlock(
          id: 'title',
          text: title,
          position: Position(size.width + 7, size.height * 0.5),
          themeOverride: const TextBlockTheme(fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  @override
  void update() {
    if (value == null || !value!) {
      transientTheme = themeOverride.copyWith(fill: Colors.grey);
    } else {
      transientTheme = themeOverride.copyWith(fill: Colors.green);
    }

    notifyListeners();
  }

  @override
  void onTap() {
    value = !(value ?? false);
    update();
  }
}
