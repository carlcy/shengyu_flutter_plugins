import 'package:flutter/material.dart';
import 'package:shengyu_flutter_plugins/init.dart';

void main() async {
  // 初始化全局管理器
  await ShengYuGlobalManager().init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Text('test')),
      ),
    );
  }
}
