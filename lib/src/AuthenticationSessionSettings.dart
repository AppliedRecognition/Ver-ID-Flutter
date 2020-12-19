import 'package:flutter/cupertino.dart';

import 'LivenessDetectionSessionSettings.dart';

/**
 * Settings for authentication sessions
 */
class AuthenticationSessionSettings extends LivenessDetectionSessionSettings {
  /**
   * ID of the user to authenticate
   */
  String userId;

  /**
   * @param userId ID of the user to authenticate
   */
  AuthenticationSessionSettings({@required String userId}) : super() {
    this.userId = userId;
  }

  /**
   * to JSON mapper for string conversion
   */
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = super.toJson();
    json.addAll({
      'userId': userId
    });
    return json;
  }
}
