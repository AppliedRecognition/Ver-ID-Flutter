class Bearing {
  final _value;
  const Bearing._internal(this._value);
  toString() => '$_value';

  static const STRAIGHT = const Bearing._internal('STRAIGHT');
  static const UP = const Bearing._internal('UP');
  static const RIGHT_UP = const Bearing._internal('RIGHT_UP');
  static const RIGHT = const Bearing._internal('RIGHT');
  static const RIGHT_DOWN = const Bearing._internal('RIGHT_DOWN');
  static const DOWN = const Bearing._internal('DOWN');
  static const LEFT_DOWN = const Bearing._internal('LEFT_DOWN');
  static const LEFT = const Bearing._internal('LEFT');
  static const LEFT_UP = const Bearing._internal('LEFT_UP');

  static Bearing fromString(dynamic bearingValue) {
    switch (bearingValue) {
      case Bearing.DOWN:
        {
          return Bearing.DOWN;
        }
        break;
      case Bearing.LEFT:
        {
          return Bearing.LEFT;
        }
        break;
      case Bearing.LEFT_DOWN:
        {
          return Bearing.LEFT_DOWN;
        }
        break;
      case Bearing.LEFT_UP:
        {
          return Bearing.LEFT_DOWN;
        }
        break;
      case Bearing.RIGHT:
        {
          return Bearing.RIGHT;
        }
        break;
      case Bearing.RIGHT_DOWN:
        {
          return Bearing.RIGHT_DOWN;
        }
        break;
      case Bearing.RIGHT_UP:
        {
          return Bearing.RIGHT_UP;
        }
        break;
      case Bearing.STRAIGHT:
        {
          return Bearing.STRAIGHT;
        }
        break;
      case Bearing.UP:
        {
          return Bearing.UP;
        }
        break;
      default:
        {
          print("Bearing value not found: " + bearingValue);
          return Bearing.STRAIGHT;
        }
        break;
    }
  }
}
