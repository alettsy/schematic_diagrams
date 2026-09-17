import 'package:schematic_diagrams/src/models/link.dart';
import 'package:schematic_diagrams/src/rendering/linking/link_renderer.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_manager.dart';

abstract class LinkManager<T extends Link> {
  LinkRenderer<T> get renderer;
  SectionManager get sectionManager;
}
