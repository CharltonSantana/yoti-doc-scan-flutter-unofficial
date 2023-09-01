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
          "dace7fb9-58b6-4bc9-9c86-041c0faf5a4d",
          "d061b35b-b090-46c5-b395-56d487f2465e");

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
              child: const Text('Start Yoti Session')),
        ),
      ),
    );
  }
}
