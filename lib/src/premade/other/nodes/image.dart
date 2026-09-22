import 'package:flutter/painting.dart';
import 'package:schematic_diagrams/src/core/mixins/mixins.dart';
import 'package:schematic_diagrams/src/models/models.dart';
import 'package:schematic_diagrams/src/rendering/standard/image_renderer.dart';

/// Static image node, that accepts an [AssetImage].
class ImageNode extends Node with Linkable {
  /// Default implementation.
  ImageNode({
    required super.id,
    required AssetImage image,
    super.position,
    super.rotation,
    super.size,
  }) : super(renderer: ImageNodeRenderer(image: image));
}
