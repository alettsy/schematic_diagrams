import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/parts/parts.dart';
import '../models/node.dart';
import '../widgets/node_widget.dart';

abstract class NodeRenderer<T extends Node> {
  const NodeRenderer();

  Widget buildContent(
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  );

  @nonVirtual
  Widget build(
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextTheme,
  ) {
    return NodeWidget(
      node: node,
      renderer: this,
      defaultNodeTheme: defaultNodeTheme,
      defaultTextTheme: defaultTextTheme,
    );
  }
}
