import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schematic_diagrams/src/core/helpers/color_helper.dart';
import 'package:schematic_diagrams/src/core/parts/node_theme.dart';
import 'package:schematic_diagrams/src/core/parts/text_block_theme.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/rendering/node_renderer.dart';

/// Renders an SVG image node by taking the [viewBox] and [svgData] parts,
/// dynamically inserting them based on their part themes, and returning
/// the result as an [SvgPicture].
class SvgDataNodeRenderer extends NodeRenderer {
  /// Default implementation.
  SvgDataNodeRenderer({required this.svgData, this.viewBox = '0 0 100 100'});

  /// Standard SVG viewbox.
  final String viewBox;

  /// The SVG data parts.
  final List<String> svgData;

  @override
  Widget buildContent(
    Node node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  ) {
    return SizedBox(
      height: node.size.height,
      width: node.size.width,
      child: SvgPicture.string(
        _generateSvg(node, defaultNodeTheme),
        height: node.size.height,
        width: node.size.width,
        fit: BoxFit.fill,
      ),
    );
  }

  String _generateSvg(Node node, NodeTheme defaultNodeTheme) {
    return '<svg viewBox="$viewBox">${_generateSvgData(node, defaultNodeTheme)}</svg>';
  }

  String _generateSvgData(Node node, NodeTheme defaultNodeTheme) {
    final result = StringBuffer();

    for (var i = 0; i < svgData.length; i++) {
      final fill = getFillColor(node, defaultNodeTheme, partIndex: i);
      final stroke = getStrokeColor(node, defaultNodeTheme, partIndex: i);
      final strokeWidth = getStrokeWidth(node, defaultNodeTheme, partIndex: i);

      result.write(
        '<path stroke="${stroke.hex}" fill="${fill.hex}" stroke-width="$strokeWidth" d="${svgData[i]}" />',
      );
    }

    return result.toString();
  }
}
