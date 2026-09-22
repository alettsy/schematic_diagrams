import 'package:example/pages/linking.dart';
import 'package:example/pages/overlapping.dart';
import 'package:example/pages/parallel.dart';
import 'package:flutter/material.dart';

const darkGrey = Color.fromARGB(255, 35, 35, 35);
const lighterGrey = Color.fromARGB(255, 50, 50, 50);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schematic Diagram Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: darkGrey,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(lighterGrey),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
            ),
          ),
        ),
      ),
      home: const NavigationOptions(),
    );
  }
}

class NavigationOptions extends StatelessWidget {
  const NavigationOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                'Schematic Diagram demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Click any of the following options to view the demos:',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              ElevatedButton(
                child: Text('Linking'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const LinkingPage(),
                    ),
                  );
                },
              ),
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
                child: Text('Coincidence adjustment'),
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
        ),
      ),
    );
  }
}
