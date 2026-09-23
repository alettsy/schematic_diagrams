import 'package:flutter/material.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';
import 'package:schematic_diagrams/premade.dart';

class OverlappingPage extends StatefulWidget {
  const OverlappingPage({super.key});

  @override
  State<OverlappingPage> createState() => _LinkingPageState();
}

class _LinkingPageState extends State<OverlappingPage> {
  final nodes = [
    VoltageIndicatorNode(id: 'v1', position: Position(300, 300)),
    FlowIndicatorNode(id: 'f1', position: Position(100, 100)),
    FlowIndicatorNode(id: 'f2', position: Position(50, 150)),
    FlowIndicatorNode(id: 'f3', position: Position(350, 150)),
  ];

  final links = [
    Link(
      id: 'example',
      fromNodeId: 'f1',
      toNodeId: 'v1',
      fromPortId: 'bottom',
      toPortId: 'top',
      inFrom: LinkDirection.top,
      outTo: LinkDirection.bottom,
    ),
    Link(
      id: 'example2',
      fromNodeId: 'f2',
      toNodeId: 'f3',
      fromPortId: 'right',
      toPortId: 'left',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.right,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overlapping'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Center(
        child: SchematicDiagram(
          model: SchematicDiagramModel(nodes: nodes, links: links),
        ),
      ),
    );
  }
}
