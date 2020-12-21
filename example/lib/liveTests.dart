import 'package:veridflutterplugin/veridflutterplugin.dart';
import 'package:veridflutterplugin/src/VerID.dart';
import 'dart:async';
import 'package:veridflutterplugin/src/RegistrationSessionSettings.dart';
import 'package:veridflutterplugin/src/AuthenticationSessionSettings.dart';
import 'package:veridflutterplugin/src/LivenessDetectionSessionSettings.dart';
import 'package:veridflutterplugin/src/SessionResult.dart';
import 'package:veridflutterplugin/src/Bearing.dart';

const verIdNotInitialized = 'VerID Instance not initialized';

class LiveTests {
  VerID verID;
  // Todo add more test functions
  Future<SessionResult> registerUser(String userId) async {
    if (verID != null) {
      RegistrationSessionSettings settings =
          new RegistrationSessionSettings(userId: userId);
      settings.bearingsToRegister = [Bearing.RIGHT];
      settings.showResult = true;
      return VerID.register(settings: settings).then((value) {
        if (value == null) {
          throw 'Session canceled';
        }
        return value;
      });
    } else {
      throw verIdNotInitialized;
    }
  }

  Future<SessionResult> authenticate(String userId) async {
    if (verID != null) {
      AuthenticationSessionSettings settings =
          new AuthenticationSessionSettings(userId: userId);
      return VerID.authenticate(settings: settings).then((value) {
        if (value == null) {
          throw 'Session canceled';
        }
        return value;
      });
    } else {
      throw verIdNotInitialized;
    }
  }

  Future<SessionResult> captureLiveFace() async {
    if (verID != null) {
      LivenessDetectionSessionSettings settings =
          new LivenessDetectionSessionSettings();
      return VerID.captureLiveFace(settings: settings).then((value) {
        if (value == null) {
          throw 'Session canceled';
        }
        return value;
      });
    } else {
      throw verIdNotInitialized;
    }
  }

  /**
   * Get a list of users with registered faces
   */
  Future<List<String>> getRegisteredUsers() async {
    if (verID != null) {
      return VerID.getRegisteredUsers();
    } else {
      throw verIdNotInitialized;
    }
  }

  /**
   * Delete user with registered faces
   * @param userId ID of the user to delete
   */
  Future<String> deleteRegisteredUser(String userId) async {
    if (verID != null) {
      return VerID.deleteRegisteredUser(userId);
    } else {
      throw verIdNotInitialized;
    }
  }

  Future<VerID> load() {
    // Platform messages may fail, so we use a try/catch PlatformException.
    return Veridflutterplugin.load().then((instance) =>
        verID = instance); //.load('efe89f85-b71f-422b-a068-605c3f62603b');
  }
}
