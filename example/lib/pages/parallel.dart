import 'package:flutter/material.dart';
import 'package:schematic_diagrams/premade.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

class ParallelPage extends StatefulWidget {
  const ParallelPage({super.key});

  @override
  State<ParallelPage> createState() => _ParallelPageState();
}

class _ParallelPageState extends State<ParallelPage> {
  final nodes = [
    VoltageIndicator(id: 'v1', position: Position(300, 300)),
    FlowIndicator(id: 'f1', position: Position(100, 100)),
    FlowIndicator(id: 'f2', position: Position(250, 150)),
    FlowIndicator(id: 'f3', position: Position(350, 250)),
    FlowIndicator(id: 'f4', position: Position(50, 75)),
    FlowIndicator(id: 'f5', position: Position(150, 250)),
  ].protected;

  final links = [
    Link(
      id: 'initial-link',
      fromNodeId: 'f1',
      toNodeId: 'v1',
      fromPortId: 'bottom',
      toPortId: 'top',
      inFrom: LinkDirection.top,
      outTo: LinkDirection.bottom,
    ),
    Link(
      id: 'needs-adjustment-1',
      fromNodeId: 'f2',
      toNodeId: 'f3',
      fromPortId: 'right',
      toPortId: 'left',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.right,
    ),
    Link(
      id: 'needs-adjustment-2',
      fromNodeId: 'f4',
      toNodeId: 'f5',
      fromPortId: 'bottom',
      toPortId: 'top',
      inFrom: LinkDirection.top,
      outTo: LinkDirection.bottom,
    ),
  ].protected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coincidence Adjustments'),
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
