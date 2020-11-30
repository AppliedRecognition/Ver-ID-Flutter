import 'Face.dart';
import 'Bearing.dart';

/**
 * Face detected during a session
 */
class DetectedFace {
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
}
