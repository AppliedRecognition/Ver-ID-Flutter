import 'package:veridflutterplugin/veridflutterplugin.dart';
import 'package:veridflutterplugin/src/VerID.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';

class LiveTests {
  // Todo add more test functions
  static void registerUser(String userId) {}

  static Future<VerID> load() async {
    String pluginProcessResult;
    VerID verID;
    ;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //platformVersion = await Veridflutterplugin.platformVersion;
      verID = await Veridflutterplugin
          .load(); //.load('efe89f85-b71f-422b-a068-605c3f62603b');
      pluginProcessResult = "";
    } on PlatformException catch (ex) {
      pluginProcessResult = 'Uncaught Platform Exception';
      developer.log(ex.message.toString());
    }
    return verID;
  }
}
