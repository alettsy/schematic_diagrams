import '../core/parts/position.dart';
import '../models/link.dart';
import '../models/node_resolver.dart';

abstract class LinkPathStrategy<T extends Link> {
  const LinkPathStrategy();

  List<Position> compute(T link, NodeResolver nodeResolver);
}
