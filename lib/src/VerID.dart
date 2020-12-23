import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/cupertino.dart';
import 'Face.dart';
import 'FaceComparisonResult.dart';
import '../veridflutterplugin.dart';
import 'RegistrationSessionSettings.dart';
import 'AuthenticationSessionSettings.dart';
import 'LivenessDetectionSessionSettings.dart';
import 'SessionResult.dart';

class VerID {
  /**
   * Register faces for user
   * @param settings Session settings
   */
  static Future<SessionResult> register(
      {@required RegistrationSessionSettings settings}) async {
    String txtResult;
    String encodedSettings = jsonEncode(settings.toJson());
    txtResult = await Veridflutterplugin.channel
        .invokeMethod('registerUser', {"settings": encodedSettings});
    if (txtResult == 'null') {
      // session canceled
      return null;
    }
    SessionResult result = SessionResult.fromJson(decodeResult(pencoded: txtResult));
    return result;
  }

  /**
   * Authenticate user
   * @param settings Session settings
   */
  static Future<SessionResult> authenticate(
      {@required AuthenticationSessionSettings settings}) async {
    String txtResult;
    String encodedSettings = jsonEncode(settings.toJson());
    txtResult = await Veridflutterplugin.channel
        .invokeMethod('authenticate', {"settings": encodedSettings});
    if (txtResult == 'null') {
      // session canceled
      return null;
    }
    SessionResult result = SessionResult.fromJson(decodeResult(pencoded: txtResult));
    return result;
  }

  /**
   * Capture a live face
   * @param settings Session settings
   */
  static Future<SessionResult> captureLiveFace(
      {@required LivenessDetectionSessionSettings settings}) async {
    String txtResult;
    String encodedSettings = jsonEncode(settings.toJson());
    txtResult = await Veridflutterplugin.channel.invokeMethod(
        'captureLiveFace', {"settings": encodedSettings});
    if (txtResult == 'null') {
      // session canceled
      return null;
    }
    SessionResult result = SessionResult.fromJson(decodeResult(pencoded: txtResult));
    return result;
  }

  /**
   * Get an array of users with registered faces
   */
  static Future<List<String>> getRegisteredUsers() async {
    String txtResult = await Veridflutterplugin.channel
        .invokeMethod('getRegisteredUsers');
    List<dynamic> decoded = jsonDecode(txtResult);
    return decoded.map((e) => e.toString()).toList();
  }

  /**
   * Delete user with registered faces
   * @param userId ID of the user to delete
   */
  static Future<String> deleteRegisteredUser(String userId) async {
    return await Veridflutterplugin.channel
        .invokeMethod('deleteUser', {'userId': userId});
  }

  /**
   * Compare faces and return a result
   * @param face1 {Face} Face to compare to the other face
   * @param face2 {Face}  Other face to compare to the first face
   */
  static Future<FaceComparisonResult> compareFaces(
      {@required Face face1, @required Face face2}) async {
    String txtResult;
    Map<String, String> options = {"face1": jsonEncode(face1), "face2": jsonEncode(face2)};
    FaceComparisonResult objFaceCompResult;
    txtResult =
        await Veridflutterplugin.channel.invokeMethod('compareFaces', options);
    objFaceCompResult =
        FaceComparisonResult.fromJson(decodeResult(pencoded: txtResult));

    return objFaceCompResult;
  }

  static Future<Face> detectFaceInImage({@required String image}) async {
    String txtResult = "";
    txtResult = await Veridflutterplugin.channel
        .invokeMethod('detectFaceInImage',  {"image": image});
    Face objFaceResult = Face.fromJson(decodeResult(pencoded: txtResult));

    return objFaceResult;
  }

  static Map<String, dynamic> decodeResult({String pencoded}) {
    Map<String, dynamic> parsedJson;
    try {
      parsedJson = jsonDecode(pencoded);
    } catch (ex) {
      developer.log(ex.toString());
    }
    return parsedJson;
  }
}
