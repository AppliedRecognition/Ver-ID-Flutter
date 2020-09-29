import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';

class Veridflutterplugin {
  static const MethodChannel _channel =
      const MethodChannel('veridflutterplugin');

  static Future<String> setTestingMode(String testingMode) async {
    try {
      return await _channel
          .invokeMethod('testingMode', {"testingMode": testingMode});
    } catch (ex) {
      developer.log(ex.toString());
      return "Exception in setTestingMode.";
    }
  }

  static Future<String> load(String password) async {
    try {
      return await _channel.invokeMethod('load', {"password": password});
    } catch (ex) {
      developer.log(ex.toString());
      return "Exception in load.";
    }
  }

  static Future<String> unload() async {
    //this only sets  a string as part of the platform implementation, nothing more expected
    return await _channel.invokeMethod('unload');
  }

  static Future<String> registerUser(String password) async {
    try {
      return await _channel
          .invokeMethod('registerUser', {"password": password});
    } catch (ex) {
      developer.log(ex.toString());
      return "Exception in registerUser.";
    }
  }

  static Future<String> authenticate(String x, String password) async {
    try {
      return await _channel
          .invokeMethod('authenticate', {"x": x, "password": password});
    } catch (ex) {
      developer.log(ex.toString());
      return "Exception in authenticate.";
    }
  }

  static Future<String> captureLiveFace(
      String settings, String password) async {
    try {
      return await _channel.invokeMethod(
          'captureLiveFace', {"settings": settings, "password": password});
    } catch (ex) {
      developer.log(ex.toString());
      return "Exception in captureLiveFace.";
    }
  }

  static Future<String> getRegisteredUsers(String password) async {
    try {
      return await _channel
          .invokeMethod('getRegisteredUsers', {"password": password});
    } catch (ex) {
      developer.log(ex.toString());
      return "Exception in authenticate.";
    }
  }

  static Future<String> deleteUser(String password, String userId) async {
    try {
      return await _channel
          .invokeMethod('deleteUser', {"userId": userId, "password": password});
    } catch (ex) {
      developer.log(ex.toString());
      return "Exception in authenticate.";
    }
  }

  static Future<String> compareFaces(
      String face1, String face2, String password) async {
    try {
      return await _channel.invokeMethod('compareFaces',
          {"face1": face1, "face2": face2, "password": password});
    } catch (ex) {
      developer.log(ex.toString());
      return "Exception in authenticate.";
    }
  }

  static Future<String> detectFaceInImage(String password, String image) async {
    try {
      return await _channel.invokeMethod(
          'detectFaceInImage', {"password": password, "image": image});
    } catch (ex) {
      developer.log(ex.toString());
      return "Exception in authenticate.";
    }
  }
}
