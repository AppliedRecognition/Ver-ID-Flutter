import 'dart:convert';
import 'DetectedFace.dart';
import 'VerIDError.dart';

/**
 * Result of a Ver-ID session
 */
class SessionResult {
  /**
   * Faces and images detected during a session
   */
  List<DetectedFace> attachments = [];
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
    if (json["attachments"] != null) {
      List<dynamic> dynamicList = json["attachments"];
      List<DetectedFace> attachments = dynamicList
          .map((detectedFace) => DetectedFace.fromJson(detectedFace))
          .toList();
      this.attachments = attachments;
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
