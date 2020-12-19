import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:veridflutterplugin/src/DetectedFace.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:developer' as developer;
import 'Face.dart';
import 'RegistrationSessionSettings.dart';
import 'AuthenticationSessionSettings.dart';
import 'LivenessDetectionSessionSettings.dart';
import 'SessionResult.dart';

class VerID {
  static const MethodChannel _channel = const MethodChannel('veridflutterplugin');

  /**
   * Register faces for user
   * @param settings Session settings
   */
  Future<SessionResult> register({@required RegistrationSessionSettings settings}) async {
    try {
      String encodedSettings = settings.toJson().toString();
      return _channel
          .invokeMethod('registerUser', {"settings": encodedSettings}).then((value) {
        if (value == 'null') {
          // session canceled
          return null;
        }
        SessionResult result = SessionResult.fromJson(jsonDecode(value));
        return result;
      });
    } catch (e) {
      developer.log(e.toString());
    }
  }

  /**
   * Authenticate user
   * @param settings Session settings
   */
  Future<SessionResult> authenticate({@required AuthenticationSessionSettings settings}) async {
    try {
      String encodedSettings = settings.toJson().toString();
      return _channel
          .invokeMethod('authenticate', {"settings": encodedSettings}).then((value) {
        if (value == 'null') {
          // session canceled
          return null;
        }
        SessionResult result = SessionResult.fromJson(jsonDecode(value));
        return result;
      });
    } catch (e) {
      developer.log(e.toString());
    }
  }
  /**
   * Capture a live face
   * @param settings Session settings
   */
  Future<SessionResult> captureLiveFace({@required LivenessDetectionSessionSettings settings}) async {
    try {
      String encodedSettings = settings.toJson().toString();
      return _channel
          .invokeMethod('captureLiveFace', {"settings": encodedSettings}).then((value) {
        if (value == 'null') {
          // session canceled
          return null;
        }
        SessionResult result = SessionResult.fromJson(jsonDecode(value));
        return result;
      });
    } catch (e) {
      developer.log(e.toString());
    }
  }
  /**
   * Get an array of users with registered faces
   */
  Future<List<String>> getRegisteredUsers() async {
    try {
      return _channel
          .invokeMethod('getRegisteredUsers').then((value) {
            developer.log(value.toString());
            List<dynamic> decoded = jsonDecode(value);
            return decoded.map((e) => e.toString()).toList();
          });
    } catch (e) {
      developer.log(e.toString());
    }
  }
  /**
   * Delete user with registered faces
   * @param userId ID of the user to delete
   */
  Future<String> deleteRegisteredUser(String userId) async {
    try {
      return _channel
          .invokeMethod('deleteUser', {'userId': userId});
    } catch (e) {
      developer.log(e.toString());
    }
  }
  /**
   * Compare faces and return a result
   * @param face1 Face to compare to the other face
   * @param face2 Other face to compare to the first face
   */
  Future<String> compareFaces(Face face1, Face face2) async {
    try {
      return _channel
          .invokeMethod('compareFaces', {'face1': face1, 'face2': face2});
    } catch (e) {
      developer.log(e.toString());
    }
  }
}
