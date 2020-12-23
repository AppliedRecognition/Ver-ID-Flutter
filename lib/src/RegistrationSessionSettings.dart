import 'package:flutter/cupertino.dart';
import 'VerIDSessionSettings.dart';
import 'Bearing.dart';

/**
 * Settings for registration sessions
 */
class RegistrationSessionSettings extends VerIDSessionSettings {
  /**
   * ID of the user to register
   */
  String userId;
  /**
   * Bearings to register in this session
   *
   * @note The number of faces to register is determined by the {@linkcode VerIDSessionSettings.numberOfResultsToCollect} parameter. If the number of results to collect exceeds the number of bearings to register the session will start take the next bearing from the beginning of the bearings array.
   *
   * For example, a session with bearings to register set to `[Bearing.STRAIGHT, Bearing.LEFT, Bearing.RIGHT]` and `numberOfResultsToCollect` set to `2` will register faces with bearings: `[Bearing.STRAIGHT, Bearing.LEFT]`.
   *
   * A session with bearings to register set to ```[Bearing.STRAIGHT, Bearing.LEFT, Bearing.RIGHT]` and `numberOfResultsToCollect` set to `2` will register faces with bearings: `[Bearing.STRAIGHT, Bearing.LEFT, Bearing.RIGHT, Bearing.STRAIGHT]`.
   */
  List<Bearing> bearingsToRegister = [
    Bearing.STRAIGHT,
    Bearing.LEFT,
    Bearing.RIGHT
  ];

  /**
   * @param userId ID of the user whose faces should be registered
   */
  RegistrationSessionSettings(
      {@required String userId, List<Bearing> bearingsToRegister})
      : super() {
    this.userId = userId;
    if (bearingsToRegister != null && bearingsToRegister.length > 0) {
      this.bearingsToRegister = bearingsToRegister;
    }
    this.numberOfResultsToCollect = 1;
  }

  /**
   * Factory method to create from JSON string
   */
  RegistrationSessionSettings.fromJson(Map<String, dynamic> json) {
    List<Bearing> tempBearings = [];
    if (json.containsKey("bearingsToRegister")) {
      List<dynamic> tempBearings = json["bearingsToRegister"];
      tempBearings.forEach((bearingValue) {
        print(bearingValue);
        switch (bearingValue) {
          case Bearing.DOWN:
            {
              tempBearings.add(Bearing.DOWN);
            }
            break;
          case Bearing.LEFT:
            {
              tempBearings.add(Bearing.LEFT);
            }
            break;
          case Bearing.LEFT_DOWN:
            {
              tempBearings.add(Bearing.LEFT_DOWN);
            }
            break;
          case Bearing.LEFT_UP:
            {
              tempBearings.add(Bearing.LEFT_UP);
            }
            break;
          case Bearing.RIGHT:
            {
              tempBearings.add(Bearing.RIGHT);
            }
            break;
          case Bearing.RIGHT_DOWN:
            {
              tempBearings.add(Bearing.RIGHT_DOWN);
            }
            break;
          case Bearing.RIGHT_UP:
            {
              tempBearings.add(Bearing.RIGHT_UP);
            }
            break;
          case Bearing.STRAIGHT:
            {
              tempBearings.add(Bearing.STRAIGHT);
            }
            break;
          case Bearing.UP:
            {
              tempBearings.add(Bearing.UP);
            }
            break;
          case Bearing.STRAIGHT:
            {
              tempBearings.add(Bearing.STRAIGHT);
            }
            break;
          default:
            {
              print("Bearing value not found: " + bearingValue);
            }
            break;
        }
      });

      if (json.containsKey("numberOfResultsToCollect")) {
        this.numberOfResultsToCollect = json["numberOfResultsToCollect"];
      }
    }
  }

  /**
   * to JSON mapper for string conversion
   */
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = super.toJson();
    json.addAll({
      'userId': userId,
      'bearingsToRegister':
        bearingsToRegister.map((e) => e.toString()).toList(),
    });
    return json;
  }
}
