import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schematic_diagrams/premade.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

class LinkingPage extends StatefulWidget {
  const LinkingPage({super.key});

  @override
  State<LinkingPage> createState() => _LinkingPageState();
}

class _LinkingPageState extends State<LinkingPage> {
  final nodes = <Node>[
    GateValve(id: 'g1', position: Position(50, 75)),
    GateValve(id: 'g2', position: Position(90, 75)),
    GateValve(id: 'g3', position: Position(50, 150)),
    GateValve(id: 'g4', position: Position(90, 150), ),
    SvgDataNode(
      id: 'svg',
      viewBox: '15.13 36.14 4.93 5.5',
      data: [
        'm 20,41 -2,-1 -2,-1 2,-1 2,-1 0,2 z m -4.8,0 2,-1, 2,-1, -2,-1, -2,-1, 0,2 z m 0.0,-4.8 0.0,5.4 4.8,0.0 0.0,-5.4 z',
      ],
      position: Position(500, 200),
      themeOverride: NodeTheme(fill: Colors.transparent, strokeWidth: 0.5),
    ),
    ImageNode(
      id: 'image',
      image: AssetImage('assets/demo_image.png'),
      position: Position(200, 200),
      size: Size(100, 100),
    ),
  ];

  final links = [
    Link(
      id: 'valves-1',
      fromNodeId: 'g1',
      toNodeId: 'g3',
      fromPortId: 'bottom',
      toPortId: 'top',
      inFrom: LinkDirection.up,
      outTo: LinkDirection.down,
    ),
    Link(
      id: 'valves-2',
      fromNodeId: 'g2',
      toNodeId: 'g4',
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
