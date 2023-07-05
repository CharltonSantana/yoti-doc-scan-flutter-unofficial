import 'package:flutter/material.dart';
import 'dart:async';

import 'package:yoti_flutter/yoti_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _yotiFlutterPlugin = YotiFlutter();

  @override
  void initState() {
    super.initState();
  }

  Future<void> startYoti() async {
    try {
      var response = await _yotiFlutterPlugin.startYoti(
          "5344dec4-eb33-4cb3-b8ee-d12fd768ad3f",
          "d0226374-4ab5-459e-a574-1f4694eb3560");

      print(response);
    } catch (error) {
      print('Platform err: ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Yoti Flutter example app'),
        ),
        body: Center(
          child: TextButton(
              onPressed: () {
                startYoti();
              },
              child: const Text('Start Yoti')),
        ),
      ),
    );
  }
}
