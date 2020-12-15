import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer;
import 'RegistrationSessionSettings.dart';
import 'AuthenticationSessionSettings.dart';
import 'LivenessDetectionSessionSettings.dart';
import 'Face.dart';
import 'FaceComparisonResult.dart';
import 'SessionResult.dart';

class VerID {
  static const MethodChannel _channel =
  const MethodChannel('veridflutterplugin');

  /**
   * Register faces for user
   * @param settings Session settings
   */
  Future<SessionResult> register({@required RegistrationSessionSettings settings}) async {
    try {
      String encodedSettings = jsonEncode(settings);
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
}

/**
register(settings: RegistrationSessionSettings): Promise<SessionResult> {
return new Promise<SessionResult>((resolve, reject) => {
let options = [{ settings: JSON.stringify(settings) }];
PluginVerId.registerUser(options).then(decodeResult(resolve)).catch(reject);
});
}
    */
