import 'dart:convert';

import 'DiagnosticInfo.dart';
import 'Face.dart';
import 'Bearing.dart';

/**
 * Face detected during a session
 */
class FaceCapture {
  /**
   * Detected face
   */
  Face recognizableFace = new Face();

  /**
   * Detected face bearing
   */
  Bearing bearing = Bearing.DOWN;

  /**
   * Image encoded using [data URI scheme](https://en.wikipedia.org/wiki/Data_URI_scheme)
   */
  String image = '';

  /**
   * Diagnostic Information of the image
   */
  DiagnosticInfo diagnosticInfo = new DiagnosticInfo();

  /**
   * Factory method to create from JSON string
   */
  FaceCapture.fromJson(Map<String, dynamic> json) {
    this.recognizableFace = Face.fromJson(json["face"]);
    this.bearing = Bearing.fromString(json["bearing"]);
    this.image = json["image"];
    this.diagnosticInfo = json['diagnosticInfo'] != null ? DiagnosticInfo.fromJson(json['diagnosticInfo']) : null;
  }
}