import 'package:schematic_diagrams/src/models/lines/line.dart';

import '../../models/link.dart';
import '../../models/node_resolver.dart';

abstract class LinkPathStrategy<T extends Link> {
  const LinkPathStrategy();

  List<Line> compute(T link, NodeResolver nodeResolver);
}
