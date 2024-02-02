import 'package:flutter/material.dart';
import 'package:total_processing/total_processing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _totalProcessingPlugin = TotalProcessing();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _totalProcessingPlugin.startCheckout();
            },
            child: const Text('TEST CHECKOUT'),
          ),
        ),
      ),
    );
  }
}
