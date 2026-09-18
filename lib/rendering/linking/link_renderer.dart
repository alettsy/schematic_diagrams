import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schematic_diagrams/core/parts/parts.dart';
import 'package:schematic_diagrams/models/link.dart';
import 'package:schematic_diagrams/rendering/linking/link_path_strategy.dart';
import 'package:schematic_diagrams/src/models/node_resolver.dart';
import 'package:schematic_diagrams/src/widgets/link_widget.dart';

/// Base renderer for how a link should look on the diagram.
abstract class LinkRenderer<T extends Link> {
  /// Default implementation.
  const LinkRenderer({required this.pathStrategy});

  /// Strategy for getting the route lines of the link.
  final LinkPathStrategy pathStrategy;

  /// How to paint the link on the screen.
  void paint(
    Canvas canvas,
    Link link,
    NodeResolver nodeResolver,
    LinkTheme defaultLinkTheme,
  );

  /// Build the [link] as [LinkWidget].
  @nonVirtual
  Widget build(T link, NodeResolver nodeResolver, LinkTheme defaultLinkTheme) {
    return LinkWidget(
      link: link,
      renderer: this,
      nodeResolver: nodeResolver,
      defaultLinkTheme: defaultLinkTheme,
    );
  }
}
