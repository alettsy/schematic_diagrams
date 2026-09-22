import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_renderer.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_section_manager.dart';
import 'package:schematic_diagrams/src/models/link.dart';
import 'package:schematic_diagrams/src/rendering/linking/link_manager.dart';
import 'package:schematic_diagrams/src/rendering/linking/link_renderer.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_manager.dart';

/// Standard manager for links which use the standard, grid [sectionManager]
/// to efficiently manage link awareness, and that use the standard link
/// [renderer] to draw themselves.
class StandardLinkManager<T extends Link> implements LinkManager {
  /// Default implementation.
  StandardLinkManager() {
    sectionManager = StandardSectionManager();
    renderer = StandardLinkRenderer<T>(sectionManager: sectionManager);
  }

  @override
  late final LinkRenderer<T> renderer;

  @override
  late final SectionManager sectionManager;
}
