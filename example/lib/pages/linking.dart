import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schematic_diagrams/pid.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

class LinkingPage extends StatefulWidget {
  const LinkingPage({super.key});

  @override
  State<LinkingPage> createState() => _LinkingPageState();
}

class _LinkingPageState extends State<LinkingPage> {
  final nodes = <Node>[
    VoltageSensorNode(id: 'v1', position: Position(300, 300)),
    FlowSensorNode(id: 'f1', position: Position(100, 100)),
    GateValve(id: 'g1', position: Position(500, 100), rotation: 90),
    ThreeWayValve(id: 'twv1', position: Position(500, 150), rotation: 0),
  ];

  final links = [
    Link(
      id: 'example',
      fromNodeId: 'f1',
      toNodeId: 'v1',
      fromPortId: 'bottom',
      toPortId: 'top',
      inFrom: LinkDirection.up,
      outTo: LinkDirection.down,
    ),
    Link(
      id: 'example-2',
      fromNodeId: 'f1',
      toNodeId: 'g1',
      fromPortId: 'right',
      toPortId: 'bottom',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.right,
    ),
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (_) {
      for (final node in nodes) {
        if (node is! Valuable) continue;

        final random = (Random().nextDouble() * 1000).roundToDouble();
        node.value = random;
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Linking'),
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
