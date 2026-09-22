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
    VoltageSensorNode(id: 'v1', position: Position(300, 300)),
    FlowSensorNode(id: 'f1', position: Position(100, 100)),
    FlowSensorNode(id: 'f2', position: Position(250, 150)),
    FlowSensorNode(id: 'f3', position: Position(350, 250)),
    FlowSensorNode(id: 'f4', position: Position(50, 75)),
    FlowSensorNode(id: 'f5', position: Position(150, 250)),
  ];

  final links = [
    Link(
      id: 'initial-link',
      fromNodeId: 'f1',
      toNodeId: 'v1',
      fromPortId: 'bottom',
      toPortId: 'top',
      inFrom: LinkDirection.up,
      outTo: LinkDirection.down,
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
      inFrom: LinkDirection.up,
      outTo: LinkDirection.down,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parallel Adjustments'),
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
