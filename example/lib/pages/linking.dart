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
  final nodes = [
    VoltageSensorNode(id: 'v1', position: Position(300, 300)),
    FlowSensorNode(id: 'f1', position: Position(100, 100)),
    GateValve(id: 'g1', position: Position(500, 100)),
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
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (_) {
      final randomNum1 = Random().nextDouble() * 1000;
      final randomNum2 = Random().nextDouble() * 1000;
      nodes.first.value = randomNum1;
      nodes.last.value = randomNum2;
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
