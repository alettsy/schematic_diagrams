import 'package:schematic_diagrams/src/internal/models/lines/line.dart';
import 'package:schematic_diagrams/src/internal/models/node_resolver.dart';
import 'package:schematic_diagrams/src/models/link.dart';
import 'package:schematic_diagrams/src/rendering/linking/section_manager.dart';

/// The routing strategy for the links.
abstract class LinkPathStrategy<T extends Link> {
  /// Create a [LinkPathStrategy] to compute the link route, and that 
  /// uses a [sectionManager] to efficiently track all lines in sections.
  const LinkPathStrategy({required this.sectionManager});

  /// The manager for tracking where this link goes by partitioning,
  /// so evaluating interactions with other links is more efficient.
  final SectionManager sectionManager;

  /// Compute the route of the [link].
  List<Line> compute(T link, NodeResolver nodeResolver);
}
