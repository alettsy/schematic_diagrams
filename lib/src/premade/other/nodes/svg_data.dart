import 'package:schematic_diagrams/src/models/models.dart';
import 'package:schematic_diagrams/src/rendering/standard/svg_data_renderer.dart';

/// SVG data path image node, which accepts the SVG data parts as a list
/// of Strings.
class SvgDataNode extends Node {
  /// Default implementation.
  SvgDataNode({
    required super.id,
    required List<String> data,
    String viewBox = '0 0 100 100',
    super.position,
    super.rotation,
    super.size,
    super.themeOverride,
  }) : super(
         renderer: SvgDataNodeRenderer(svgData: data, viewBox: viewBox),
       );
}
