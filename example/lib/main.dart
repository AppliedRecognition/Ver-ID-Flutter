import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:veridflutterplugin/veridflutterplugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _loadResult = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String pluginProcessResult;
    Map<String, dynamic> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //platformVersion = await Veridflutterplugin.platformVersion;
      result = await Veridflutterplugin.load(
          null); //.load('efe89f85-b71f-422b-a068-605c3f62603b');
      pluginProcessResult = result.toString();
    } on PlatformException catch (ex) {
      pluginProcessResult = 'Uncaught Platform Exception';
      developer.log(ex.message.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _loadResult = pluginProcessResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ver-ID plugin example app'),
        ),
        body: Center(
          //child: Text('Running on: $_platformVersion\n' ),
          child: Text('Load result: $_loadResult\n'),
        ),
      ),
    );
  }
}
