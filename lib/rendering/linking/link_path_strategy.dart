import 'package:schematic_diagrams/models/link.dart';
import 'package:schematic_diagrams/rendering/linking/section_manager.dart';
import 'package:schematic_diagrams/src/models/lines/line.dart';
import 'package:schematic_diagrams/src/models/node_resolver.dart';

/// The routing strategy for the links.
abstract class LinkPathStrategy<T extends Link> {
  /// Default implementation.
  const LinkPathStrategy({required this.sectionManager});

  /// The manager for tracking where this link goes by partitioning,
  /// so evaluating interactions with other links is more efficient.
  final SectionManager sectionManager;

  /// Compute the route of the [link].
  List<Line> compute(T link, NodeResolver nodeResolver);
}
