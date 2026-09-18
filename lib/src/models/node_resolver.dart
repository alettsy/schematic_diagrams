
import 'package:schematic_diagrams/src/models/node.dart';

/// Interface for specifying the ability to get a node from its
/// ID.
abstract class NodeResolver {

  /// Return a node, if any, based on the given [nodeId].
  Node? getNode(String nodeId);
}
