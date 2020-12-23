import 'package:veridflutterplugin/veridflutterplugin.dart';
import 'package:veridflutterplugin/src/VerID.dart';
import 'dart:async';
import 'package:veridflutterplugin/src/RegistrationSessionSettings.dart';
import 'package:veridflutterplugin/src/AuthenticationSessionSettings.dart';
import 'package:veridflutterplugin/src/LivenessDetectionSessionSettings.dart';
import 'package:veridflutterplugin/src/SessionResult.dart';
import 'package:veridflutterplugin/src/Face.dart';
import 'package:veridflutterplugin/src/FaceComparisonResult.dart';

const verIdNotInitialized = 'VerID Instance not initialized';

class LiveTests {
  static LiveTests instance;
  VerID verID;

  static LiveTests getInstance() {
    if (instance == null) {
      instance = new LiveTests();
    }
    return instance;
  }
  /**
   * Register faces for user
   * @param settings Session settings
   */
  Future<SessionResult> registerUser(String userId) async {
    if (verID != null) {
      RegistrationSessionSettings settings =
          new RegistrationSessionSettings(userId: userId);
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
  /**
   * Authenticate user
   * @param settings Session settings
   */
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
  /**
   * Capture a live face
   * @param settings Session settings
   */
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
  /**
   * Compare faces and return a result
   * @param face1 Face to compare to the other face
   * @param face2 Other face to compare to the first face
   */
  Future<FaceComparisonResult> compareFaces(Face face1, Face face2) async {
    if (verID != null) {
      return VerID.compareFaces(face1: face1, face2: face2);
    } else {
      throw verIdNotInitialized;
    }
  }
  /**
   * Detect a face in image
   * @param image [Data URI scheme](https://en.wikipedia.org/wiki/Data_URI_scheme) encoded image in which to detect a face
   */
  Future<Face> detectFaceInImage(String imageData) async {
    if (verID != null) {
      return VerID.detectFaceInImage(image: imageData);
    } else {
      throw verIdNotInitialized;
    }
  }

  Future<VerID> load() {
    return Veridflutterplugin.load().then((instance) =>
        verID = instance); //.load('efe89f85-b71f-422b-a068-605c3f62603b');
  }

  Future<String> unload() {
    return Veridflutterplugin.unload().then((result) {
      verID = null;
      return "OK";
    });
  }
}
