import 'package:schematic_diagrams/models/link.dart';
import 'package:schematic_diagrams/src/rendering/linking/link_manager.dart';
import 'package:schematic_diagrams/src/rendering/linking/link_renderer.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_manager.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_link_renderer.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_section_manager.dart';

class StandardLinkManager<T extends Link> implements LinkManager {
  StandardLinkManager() {
    sectionManager = StandardSectionManager();

    renderer = StandardLinkRenderer<T>(sectionManager: sectionManager);
  }

  @override
  late final LinkRenderer<T> renderer;

  @override
  late final SectionManager sectionManager;
}
