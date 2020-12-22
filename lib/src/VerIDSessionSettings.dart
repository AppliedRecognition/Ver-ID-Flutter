/**
 * Base class for Ver-ID session settings
 */
class VerIDSessionSettings {
  /**
   * Time it will take for the session to expire (in seconds)
   */
  num expiryTime = 30.0;
  /**
   * The number of detected faces and images the session must collect before finishing
   */
  num numberOfResultsToCollect = 2;
  /**
   * Set to `true` to display the result of the session to the user
   */
  bool showResult = false;

  /**
   * to JSON mapper for string conversion
   */
  Map<String, dynamic> toJson() {
    return {
      'expiryTime': expiryTime,
      'numberOfResultsToCollect': numberOfResultsToCollect,
      'showResult': showResult
    };
  }
}
