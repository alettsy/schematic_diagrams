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
    ToggleNode(
      id: 'toggle',
      title: 'Press to toggle on/off',
      position: Position(300, 50),
    ),
    LabelNode(
      id: 'title',
      label: 'Demo diagram!',
      position: Position(10, 12),
      drawWidth: 250,
      textBlockThemeOverride: TextBlockTheme(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    IoNode(
      id: 'io-1',
      label: 'IN A',
      position: Position(57, 30),
      themeOverride: NodeTheme(fill: Colors.orange),
    ),
    IoNode(
      id: 'io-2',
      label: 'IN B',
      position: Position(107, 30),
      themeOverride: NodeTheme(fill: Colors.purple),
    ),
    IoNode(
      id: 'io-3',
      label: 'OUT A',
      position: Position(220, 307),
      themeOverride: NodeTheme(fill: Colors.red),
      rotation: 270,
    ),
    IoNode(
      id: 'io-4',
      label: 'OUT B',
      position: Position(420, 367),
      themeOverride: NodeTheme(fill: Colors.blue),
      rotation: 270,
    ),
    IoNode(
      id: 'io-5',
      label: 'OUT C',
      position: Position(420, 400),
      themeOverride: NodeTheme(fill: Colors.pink),
      rotation: 270,
    ),
    GateValve(id: 'g1', position: Position(50, 75)),
    GateValve(id: 'g2', position: Position(100, 75)),
    GateValve(id: 'g3', position: Position(50, 150)),
    GateValve(id: 'g4', position: Position(100, 150)),
    FlowIndicatorNode(
      id: 'flow-1',
      position: Position(72, 250),
      title: 'Flow 1',
    ),
    VoltageIndicatorNode(
      id: 'volt-1',
      position: Position(100, 300),
      title: 'Voltage 1',
    ),
    PressureIndicator(
      id: 'press-1',
      position: Position(100, 350),
      title: 'Pressure 1',
    ),
    LevelIndicator(
      id: 'level-1',
      position: Position(100, 400),
      title: 'Level 1',
    ),
    SvgDataNode(
      id: 'heat-exchanger',
      viewBox: '15.13 36.14 4.93 5.5',
      data: [
        'm 20,41 -2,-1 -2,-1 2,-1 2,-1 0,2 z m -4.8,0 2,-1, 2,-1, -2,-1, -2,-1, 0,2 z m 0.0,-4.8 0.0,5.4 4.8,0.0 0.0,-5.4 z',
      ],
      position: Position(250, 367),
      size: Size(48, 48),
      themeOverride: NodeTheme(fill: Colors.transparent, strokeWidth: 0.5),
      ports: [
        Port(id: 'tl', position: Position(2, 2)),
        Port(id: 'tr', position: Position(46, 2)),
        Port(id: 'bl', position: Position(2, 46)),
        Port(id: 'br', position: Position(46, 46)),
      ],
    ),
    LabelNode(
      id: 'label-1',
      label: 'Static image:',
      position: Position(500, 140),
      drawWidth: 250,
      textBlockThemeOverride: TextBlockTheme(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    ImageNode(
      id: 'image',
      image: AssetImage('assets/demo_image.png'),
      position: Position(500, 150),
      size: Size(100, 100),
    ),
  ];

  final links = [
    Link(
      id: 'entry-valve-1',
      fromNodeId: 'io-1',
      toNodeId: 'g1',
      fromPortId: 'bottom',
      toPortId: 'top',
      inFrom: LinkDirection.up,
      outTo: LinkDirection.down,
    ),
    Link(
      id: 'entry-valve-2',
      fromNodeId: 'io-2',
      toNodeId: 'g2',
      fromPortId: 'bottom',
      toPortId: 'top',
      inFrom: LinkDirection.up,
      outTo: LinkDirection.down,
    ),
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
    Link(
      id: 'valves-flow-1',
      fromNodeId: 'g3',
      toNodeId: 'flow-1',
      fromPortId: 'bottom',
      toPortId: 'left',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.down,
    ),
    Link(
      id: 'valves-flow-2',
      fromNodeId: 'g4',
      toNodeId: 'flow-1',
      fromPortId: 'bottom',
      toPortId: 'right',
      inFrom: LinkDirection.right,
      outTo: LinkDirection.down,
    ),
    Link(
      id: 'flow-volt',
      fromNodeId: 'flow-1',
      toNodeId: 'volt-1',
      fromPortId: 'bottom',
      toPortId: 'left',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.down,
    ),
    Link(
      id: 'flow-press',
      fromNodeId: 'flow-1',
      toNodeId: 'press-1',
      fromPortId: 'bottom',
      toPortId: 'left',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.down,
    ),
    Link(
      id: 'flow-level',
      fromNodeId: 'flow-1',
      toNodeId: 'level-1',
      fromPortId: 'bottom',
      toPortId: 'left',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.down,
    ),
    Link(
      id: 'volt-out',
      fromNodeId: 'volt-1',
      toNodeId: 'io-3',
      fromPortId: 'right',
      toPortId: 'top',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.right,
    ),
    Link(
      id: 'heat-in-1',
      fromNodeId: 'press-1',
      toNodeId: 'heat-exchanger',
      fromPortId: 'right',
      toPortId: 'tl',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.right,
      themeOverride: LinkTheme(stroke: Colors.red),
    ),
    Link(
      id: 'heat-in-2',
      fromNodeId: 'level-1',
      toNodeId: 'heat-exchanger',
      fromPortId: 'right',
      toPortId: 'bl',
      inFrom: LinkDirection.left,
      outTo: LinkDirection.right,
    ),
    Link(
      id: 'heat-out-1',
      fromNodeId: 'heat-exchanger',
      toNodeId: 'io-4',
      fromPortId: 'tr',
      toPortId: 'top',
      inFrom: LinkDirection.right,
      outTo: LinkDirection.left,
    ),
    Link(
      id: 'heat-out-2',
      fromNodeId: 'heat-exchanger',
      toNodeId: 'io-5',
      fromPortId: 'br',
      toPortId: 'top',
      inFrom: LinkDirection.right,
      outTo: LinkDirection.left,
      themeOverride: LinkTheme(stroke: Colors.yellow),
    ),
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (_) {
      for (final node in nodes) {
        if (node is! Valuable<double>) continue;

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
