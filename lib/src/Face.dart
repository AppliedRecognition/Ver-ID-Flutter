import 'dart:convert';

import 'FaceTemplate.dart';

/**
 * Represents a detected face
 */
class Face {
  /**
   * Distance of the left edge of the face from the left edge of the image (in pixels)
   */
  num x = 0;

  /**
   * Distance of the top edge of the face from the top edge of the image (in pixels)
   */
  num y = 0;

  /**
   * Width of the face in the image (in pixels)
   */
  num width = 0;

  /**
   * Height of the face in the image (in pixels)
   */
  num height = 0;

  /**
   * Yaw of the face in relation to the camera
   */
  num yaw = 0;

  /**
   * Pitch of the face in relation to the camera
   */
  num pitch = 0;

  /**
   * Roll of the face in relation to the camera
   */
  num roll = 0;

  /**
   * leftEye
   */
  List leftEye = [];
  /**
   * Data used for face recognition
   */
  String data = "";

  /**
   * rightEye
   */
  List<num> rightEye = [];

  /**
   * Quality of the face landmarks (10 maximum)
   */
  num quality = 0;

  /**
   * Face template used for face recognition, initialized in Face constructor
   */
  FaceTemplate faceTemplate;

  Face(
      {num px,
      num py,
      num pwidth,
      num pheight,
      num pyaw,
      num ppitch,
      num proll,
      List pLeftEye,
      String data,
      List pRightEye,
      num quality}) {
    this.faceTemplate = new FaceTemplate();
  }

  Face.fromJson(Map<String, dynamic> json) {
    this.x = json["x"];
    this.y = json["y"];
    this.width = json["width"];
    this.height = json["height"];
    this.yaw = json["yaw"];
    this.pitch = json["pitch"];
    this.roll = json["roll"];
    this.leftEye = json["leftEye"];
    this.data = json["data"];
    this.rightEye = json["rightEye"];
    this.quality = json["quality"];
    this.faceTemplate = FaceTemplate.fromJson(json["faceTemplate"]);
  }

  /**
   * to JSON mapper for string conversion
   */
  Map<String, dynamic> toJson() {
    return {
      'x': this.x,
      'y': this.y,
      'width': this.width,
      'height': this.height,
      'yaw': this.yaw,
      'pitch': this.pitch,
      'roll': this.roll,
      'leftEye': this.leftEye,
      'data': this.data,
      'rightEye': this.rightEye,
      'quality': this.quality,
      'faceTemplate': this.faceTemplate.toJson()
    };
  }
}
