import 'dart:convert';
import 'FaceCapture.dart';
import 'VerIDError.dart';

/**
 * Result of a Ver-ID session
 */
class SessionResult {
  /**
   * Faces and images detected during a session
   */
  List<FaceCapture> attachments = [];

  /**
   * Error (if any) that caused the session to fail
   */
  VerIDError error;

  /**
   * Factory method to create from JSON string
   */
  SessionResult.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    if (json["faceCaptures"] != null) {
      List<dynamic> dynamicList = json["faceCaptures"];

      List<FaceCapture> aux = dynamicList
          .map((detectedFace) => FaceCapture.fromJson(detectedFace))
          .toList();

      this.attachments = aux.toList();
    }
    if (json["error"] != null) {
      try {
        this.error = VerIDError.fromJson(json["error"]);
      } catch (e) {
        throw json["error"];
      }
    }
  }
}
