import 'package:schematic_diagrams/src/models/models.dart';
import 'package:schematic_diagrams/src/rendering/standard/svg_data_renderer.dart';

class SvgDataNode extends Node {
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
