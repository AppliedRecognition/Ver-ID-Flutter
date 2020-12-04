import 'package:veridflutterplugin/src/DetectedFace.dart';
import 'VerIDError.dart';

/**
 * Result of a Ver-ID session
 */
class SessionResult {
  /**
   * Faces and images detected during a session
   */
  List<DetectedFace> attachments = [];
  /**
   * Error (if any) that caused the session to fail
   */
  VerIDError error;
}
