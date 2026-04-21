import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/rendering/link_path_strategy.dart';

import '../core/parts/link_theme.dart';
import '../models/link.dart';
import '../models/node_resolver.dart';
import '../widgets/link_widget.dart';

abstract class LinkRenderer<T extends Link> {
  const LinkRenderer({required this.pathStrategy});

  final LinkPathStrategy pathStrategy;

  void paint(
    Canvas canvas,
    Link link,
    NodeResolver nodeResolver,
    LinkTheme defaultLinkTheme,
  );

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
