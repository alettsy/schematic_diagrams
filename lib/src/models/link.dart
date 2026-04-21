import '../core/parts/link_direction.dart';
import '../core/parts/link_theme.dart';

class Link {
  Link({
    required this.id,
    required this.fromNodeId,
    required this.toNodeId,
    required this.fromPortId,
    required this.toPortId,
    required this.outTo,
    required this.inFrom,
    this.themeOverride = const LinkTheme(),
  });

  final String id;
  final String fromNodeId;
  final String toNodeId;
  final String fromPortId;
  final String toPortId;
  final LinkDirection outTo;
  final LinkDirection inFrom;
  final LinkTheme themeOverride;
  LinkTheme? transientTheme;

  LinkTheme get activeTheme => transientTheme ?? themeOverride;
}
