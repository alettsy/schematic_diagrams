import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nodes = [
    VoltageSensorNode(id: 'v1', position: Position(300, 300)),
    FlowSensorNode(id: 'f1', position: Position(100, 100)),
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
      body: Center(
        child: SchematicDiagram(
          model: SchematicDiagramModel(
            nodes: nodes,
            links: [
              Link(
                id: '1',
                fromNodeId: 'v1',
                fromPortId: '1',
                inFrom: LinkDirection.up,
                outTo: LinkDirection.left,
                toNodeId: 'f1',
                toPortId: '1',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
