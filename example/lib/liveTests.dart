import 'package:veridflutterplugin/veridflutterplugin.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';

class LiveTests {
  // Todo add more test functions
  static void registerUser(String userId) {
  }

  static Future<String> load() async {
    String pluginProcessResult;
    Map<String, dynamic> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //platformVersion = await Veridflutterplugin.platformVersion;
      result = await Veridflutterplugin.load(null); //.load('efe89f85-b71f-422b-a068-605c3f62603b');
      pluginProcessResult = result.toString();
    } on PlatformException catch (ex) {
      pluginProcessResult = 'Uncaught Platform Exception';
      developer.log(ex.message.toString());
    }
    return pluginProcessResult;
  }
}