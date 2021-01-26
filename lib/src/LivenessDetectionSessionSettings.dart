import 'VerIDSessionSettings.dart';
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

  /**
   * to JSON mapper for string conversion
   */
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = super.toJson();
    json.addAll({
      'bearings': bearings.map((e) => e.toString()).toList(),
    });
    return json;
  }
}
