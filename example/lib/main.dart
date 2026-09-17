import 'package:example/pages/linking.dart';
import 'package:example/pages/overlapping.dart';
import 'package:example/pages/parallel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schematic Diagram Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const NavigationOptions(),
    );
  }
}

class NavigationOptions extends StatelessWidget {
  const NavigationOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(child: Text('Linking'), onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const LinkingPage(),
              ),
            );
          },),
          ElevatedButton(
            child: Text('Overlapping'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const OverlappingPage(),
                ),
              );
            },
          ),
          ElevatedButton(
            child: Text('Parallel adjustment'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const ParallelPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
