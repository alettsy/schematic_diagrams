import 'package:flutter/foundation.dart';
import 'package:schematic_diagrams/src/core/mixins/mixins.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/models.dart';
import 'package:schematic_diagrams/src/rendering/standard/svg_data_renderer.dart';

/// SVG data path image node, which accepts the SVG data parts as a list
/// of Strings.
class SvgDataNode extends Node
    with ChangeNotifier, Updatable, Valuable<double>, TextBlockable, Linkable {
  /// Default implementation.
  SvgDataNode({
    required super.id,
    required List<String> data,
    String viewBox = '0 0 100 100',
    super.position,
    super.rotation,
    super.size,
    super.themeOverride,
    List<Port>? ports,
    List<TextBlock>? textBlocks,
  }) : super(
         renderer: SvgDataNodeRenderer(svgData: data, viewBox: viewBox),
       ) {
    this.ports = (ports ?? []).protected;
    this.textBlocks = (textBlocks ?? []).protected;
  }

  @override
  void update() {}
}
