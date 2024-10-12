import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:my_app/src/models/email.dart';
import 'package:my_app/src/rust/api/simple.dart';
import 'package:my_app/src/rust/frb_generated.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  await RustLib.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> _deviceMap = {};

  @override
  void initState() {
    loadInfo();
    super.initState();
  }

  void initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [EmailSchema],
      directory: dir.path,
    );
    final newEmail = Email()
      ..title = "Hello World"
      ..recipients = [
        Recipient()
          ..name = "John"
          ..address = "john@example.com"
      ];

    await isar.writeTxn((isar) async {
      await isar.emails.put(newEmail);
    } as Future Function());
  }

  void loadInfo() async {
    _deviceMap = jsonDecode(osInfo());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
          body: SizedBox(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _deviceMap.entries
                      .map((e) => Text("${e.key}: ${e.value}"))
                      .toList()),
            ),
          )),
    );
  }
}
