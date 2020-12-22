import 'package:flutter/material.dart';
import 'dart:async';
import 'package:veridflutterplugin_example/liveTests.dart';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:veridflutterplugin/veridflutterplugin.dart';
import 'package:veridflutterplugin/src/VerID.dart';
import 'uiUtils.dart';
import 'compareFacesView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _loadResult = 'Unknown';
  String _operationResult = '';
  LiveTests liveTests = LiveTests.getInstance();
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String pluginProcessResult;
    VerID result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //platformVersion = await Veridflutterplugin.platformVersion;
      result = await Veridflutterplugin
          .load(); //.load('efe89f85-b71f-422b-a068-605c3f62603b');
      pluginProcessResult = "VerID instance loaded successfully.";
    } on PlatformException catch (ex) {
      pluginProcessResult = 'Platform Exception: ' + ex.message.toString();
      developer.log(ex.message.toString());
    } on String catch (e) {
      pluginProcessResult = e;
      developer.log(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _loadResult = pluginProcessResult;
    });
  }

  void onError(e) {
    if (e != null) {
      setState(() {
        _operationResult = 'Error is: $e';
      });
    }
  }
  void onSuccess(message) {
    setState(() {
      _operationResult = 'Success: $message';
    });
  }

  void handleSessionResult(session) {
    if (session.error != null) {
      onError(session.error.toString());
    } else {
      onSuccess(session);
    }
  }

  List<Widget> getMainContent(context) {
    List<Widget> buttons = [];
    buttons.add(UiUtils.createButton('load', () {
      liveTests.load().then(onSuccess).catchError(onError);
    }));
    buttons.add(UiUtils.createButton('Register User', () {
      liveTests.registerUser('userId').then(handleSessionResult).catchError(onError);
    }));
    buttons.add(UiUtils.createButton('Authenticate', () {
      liveTests.authenticate('userId').then(handleSessionResult).catchError(onError);
    }));
    buttons.add(UiUtils.createButton('Capture Live Face', () {
      liveTests.captureLiveFace().then(handleSessionResult).catchError(onError);
    }));
    buttons.add(UiUtils.createButton('Compare Faces', () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return CompareFaces();
        })
      );
    }));
    buttons.add(UiUtils.createButton('Get Registered Users', () {
      liveTests.getRegisteredUsers().then(onSuccess).catchError(onError);
    }));
    buttons.add(UiUtils.createButton('Delete registered User', () {
      liveTests.deleteRegisteredUser('userId').then(onSuccess).catchError(onError);
    }));
    List<Widget> content = [Center(child: Text('Load result: $_loadResult\n')),
      Center(child: Text('Operation result: $_operationResult\n'))];
    content.addAll(buttons);

    return content;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
          builder: (context) =>
              Scaffold(
                  appBar: AppBar(
                    title: const Text('Ver-ID plugin example app'),
                  ),
                  body: Center(
                    //child: Text('Running on: $_platformVersion\n' ),
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                        children: getMainContent(context),
                      )
                  )
              ),
      ),
    );
  }
}
