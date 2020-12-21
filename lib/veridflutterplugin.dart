import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'src/VerID.dart';

class Veridflutterplugin {
  //moving to be accessible outside of the plugin implementation for ordering purposes.
  static const MethodChannel channel =
      const MethodChannel('veridflutterplugin');

  static String createJsonError(String message) {
    String errorJson;

    errorJson = "{ error: \"" + message + "\" }";

    return errorJson;
  }

  static Future<String> setTestingMode(String testingMode) async {
    try {
      return await channel
          .invokeMethod('testingMode', {"testingMode": testingMode});
    } catch (ex) {
      developer.log(ex.toString());
      return "Exception in setTestingMode.";
    }
  }

  /**
   * Load Ver-ID
   * @param password Ver-ID API password (if omitted the library will look in the app's plist (iOS) or manifest (Android))
   * @returns Promise whose resolve function's argument contains the loaded Ver-ID instance
   * @example
   */
  static Future<VerID> load({String password}) async {
    String tempResult;
    VerID resultObj;
    tempResult = await channel.invokeMethod('load', {"password": password});
    resultObj = new VerID();

    developer.log(tempResult);
    return resultObj;
  }

  static Future<Map> unload() async {
    //this only sets  a string as part of the platform implementation, nothing more expected
    String result = "{}", tempResult;
    Map<String, dynamic> resultJson = new Map<String, dynamic>();
    try {
      tempResult = await channel.invokeMethod('unload');
      resultJson = jsonDecode(result);
    } on PlatformException catch (ex) {
      developer.log(ex.toString());
      resultJson = jsonDecode(createJsonError(ex.message.toString()));
    } finally {
      return resultJson;
    }
  }
}
