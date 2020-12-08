import 'package:flutter/cupertino.dart';

import 'RegistrationSessionSettings.dart';
import 'AuthenticationSessionSettings.dart';
import 'LivenessDetectionSessionSettings.dart';
import 'Face.dart';
import 'FaceComparisonResult.dart';
import 'SessionResult.dart';
import '../veridflutterplugin.dart';

class VerID {}
/**
 * Register faces for user
 * @param settings Session settings
 */
/**
  Future<SessionResult> register({@required RegistrationSessionSettings settings}) async {
    String options =
  }
register(settings: RegistrationSessionSettings): Promise<SessionResult> {
return new Promise<SessionResult>((resolve, reject) => {
let options = [{ settings: JSON.stringify(settings) }];
PluginVerId.registerUser(options).then(decodeResult(resolve)).catch(reject);
});
}
    */
