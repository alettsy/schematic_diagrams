import 'package:schematic_diagrams/src/models/lines/line.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_manager.dart';

import '../../models/link.dart';
import '../../models/node_resolver.dart';

abstract class LinkPathStrategy<T extends Link> {
  const LinkPathStrategy({required this.sectionManager});

  final SectionManager sectionManager;

  List<Line> compute(T link, NodeResolver nodeResolver);
}
