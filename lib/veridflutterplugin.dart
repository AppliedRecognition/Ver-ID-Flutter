import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'src/VerID.dart';

class Veridflutterplugin {
  static const MethodChannel _channel =
      const MethodChannel('veridflutterplugin');

  static String createJsonError(String message) {
    String errorJson;

    errorJson = "{ error: \"" + message + "\" }";

    return errorJson;
  }

  static Future<String> setTestingMode(String testingMode) async {
    try {
      return await _channel
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
   * ```typescript
   *
   * verid.load().then(instance => {
   *    // You can now call instance methods
   * }).catch(error => {
   *    // Load failed
   * });
   * ```
   */
  static Future<VerID> load({String password}) async {
    String tempResult, result = "";
    Map<String, dynamic> resultJson = new Map<String, dynamic>();
    VerID resultObj;

    tempResult = await _channel.invokeMethod('load', {"password": password});
    resultObj = new VerID();
    /*} on PlatformException catch (ex) {
      developer.log(ex.toString());
      result = createJsonError(ex.message.toString());
    } catch (ex) {
      developer.log(ex.toString());
    */
    developer.log(tempResult);
    return resultObj;
  }

  static Future<Map> unload() async {
    //this only sets  a string as part of the platform implementation, nothing more expected
    String result = "{}", tempResult;
    Map<String, dynamic> resultJson = new Map<String, dynamic>();
    try {
      tempResult = await _channel.invokeMethod('unload');
      resultJson = jsonDecode(result);
    } on PlatformException catch (ex) {
      developer.log(ex.toString());
      resultJson = jsonDecode(createJsonError(ex.message.toString()));
    } finally {
      return resultJson;
    }
  }

  static Future<Map> registerUser(String password) async {
    String result = "";
    Map<String, dynamic> resultJson = new Map<String, dynamic>();
    try {
      result =
          await _channel.invokeMethod('registerUser', {"password": password});
      resultJson = jsonDecode(result);
    } on PlatformException catch (ex) {
      developer.log(ex.toString());
      resultJson = jsonDecode(createJsonError(ex.message.toString()));
    } finally {
      return resultJson;
    }
  }

  static Future<Map> authenticate(String x, String password) async {
    String result = "";
    Map<String, dynamic> resultJson = new Map<String, dynamic>();
    try {
      result = await _channel
          .invokeMethod('authenticate', {"x": x, "password": password});
      resultJson = jsonDecode(result);
    } on PlatformException catch (ex) {
      developer.log(ex.toString());
      resultJson = jsonDecode(createJsonError(ex.message.toString()));
    } catch (ex2) {
      developer.log(ex2.toString());
      resultJson = jsonDecode(createJsonError(ex2.toString()));
    } finally {
      return resultJson;
    }
  }

  static Future<Map> captureLiveFace(String settings, String password) async {
    String result = "";
    Map<String, dynamic> resultJson = new Map<String, dynamic>();
    try {
      result = await _channel.invokeMethod(
          'captureLiveFace', {"settings": settings, "password": password});
      resultJson = jsonDecode(result);
    } catch (ex) {
      developer.log(ex.toString());
      resultJson = jsonDecode(createJsonError("Exception in captureLiveFace."));
    } finally {
      return resultJson;
    }
  }

  static Future<Map> getRegisteredUsers(String password) async {
    String result = "";
    Map<String, dynamic> resultJson = new Map<String, dynamic>();
    try {
      result = await _channel
          .invokeMethod('getRegisteredUsers', {"password": password});
      resultJson = jsonDecode(result);
    } catch (ex) {
      developer.log(ex.toString());
      resultJson = jsonDecode(createJsonError("Exception in authenticate."));
    } finally {
      return resultJson;
    }
  }

  static Future<Map> deleteUser(String password, String userId) async {
    String result = "";
    Map<String, dynamic> resultJson = new Map<String, dynamic>();
    try {
      result = await _channel
          .invokeMethod('deleteUser', {"userId": userId, "password": password});
      resultJson = jsonDecode(result);
    } catch (ex) {
      developer.log(ex.toString());
      resultJson = jsonDecode(createJsonError("Exception in authenticate."));
    } finally {
      return resultJson;
    }
  }

  static Future<Map> compareFaces(
      String face1, String face2, String password) async {
    String result = "";
    Map<String, dynamic> resultJson = new Map<String, dynamic>();
    try {
      result = await _channel.invokeMethod('compareFaces',
          {"face1": face1, "face2": face2, "password": password});
      resultJson = jsonDecode(result);
    } catch (ex) {
      developer.log(ex.toString());
      resultJson = jsonDecode(createJsonError("Exception in authenticate."));
    } finally {
      return resultJson;
    }
  }

  static Future<Map> detectFaceInImage(String password, String image) async {
    String result = "";
    Map<String, dynamic> resultJson = new Map<String, dynamic>();
    try {
      result = await _channel.invokeMethod(
          'detectFaceInImage', {"password": password, "image": image});
      resultJson = jsonDecode(result);
    } catch (ex) {
      developer.log(ex.toString());
      resultJson = jsonDecode(createJsonError("Exception in authenticate."));
    } finally {
      return resultJson;
    }
  }
}
