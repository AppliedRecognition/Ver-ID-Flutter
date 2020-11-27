import 'package:flutter/material.dart';
import 'dart:async';
import 'package:veridflutterplugin_example/liveTests.dart';

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
    if (!mounted) return;
  }

  Future<void> load() async {
    String result = await LiveTests.load();
    setState(() {
      _loadResult = result;
    });
  }

  List<Widget> getButtonList() {
    List<RaisedButton> buttons = [];
    buttons.add(createButton('load', () {load();}));
    buttons.add(createButton('Register User', () {LiveTests.registerUser('userId');}));
    return buttons;
  }

  Widget createButton(String name, Function callback) {
    return RaisedButton(onPressed: callback, child: Text(name), color: Colors.blue, textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [ Center(child: Text('Load result: $_loadResult\n'))];
    content.addAll(getButtonList().map((Widget button){
      return button;
    }).toList());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ver-ID plugin example app'),
        ),
        body: Center(
          //child: Text('Running on: $_platformVersion\n' ),
          child:ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
            children: content,
          )
        ),
      ),
    );
  }
}
