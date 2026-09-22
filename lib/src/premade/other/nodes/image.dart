import 'package:flutter/painting.dart';
import 'package:schematic_diagrams/src/models/models.dart';
import 'package:schematic_diagrams/src/rendering/standard/image_renderer.dart';

class ImageNode extends Node {
  ImageNode({
    required super.id,
    required AssetImage image,
    super.position,
    super.rotation,
    super.size,
  }) : super(renderer: ImageNodeRenderer(image: image));
}
