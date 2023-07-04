import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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
          "2386e668-9f8c-43dc-9af8-ecd3744ee48d",
          "c79f0ffe-a784-465d-b732-9a962c83026c");
    } on PlatformException {
      print('Failed to get platform version.');
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
