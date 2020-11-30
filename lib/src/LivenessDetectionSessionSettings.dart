import 'package:veridflutterplugin/src/VerIDSessionSettings.dart';
import 'Bearing.dart';

/**
 * Settings for liveness detection sessions
 */
class LivenessDetectionSessionSettings extends VerIDSessionSettings {
  /**
   * Default pool of bearings the session will draw from when asking for a random pose
   */
  static List<Bearing> DEFAULT_BEARINGS = [
    Bearing.STRAIGHT,
    Bearing.LEFT,
    Bearing.LEFT_UP,
    Bearing.RIGHT_UP,
    Bearing.RIGHT,
  ];

  /**
   * The bearings the session will draw from when asking for a random pose
   */
  List<Bearing> bearings = LivenessDetectionSessionSettings.DEFAULT_BEARINGS;
}
