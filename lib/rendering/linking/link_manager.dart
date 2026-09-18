import 'package:schematic_diagrams/models/link.dart';
import 'package:schematic_diagrams/rendering/linking/link_renderer.dart';
import 'package:schematic_diagrams/rendering/linking/section_manager.dart';

/// Manager for links.
/// 
/// Contains how links should be rendered and keeps track of links by
/// partitioning the diagram into regions for more efficient operations.
abstract class LinkManager<T extends Link> {
  /// How to render the link on the diagram.
  LinkRenderer<T> get renderer;

  /// How to manage the sections that the links take up on the diagram.
  SectionManager get sectionManager;
}
