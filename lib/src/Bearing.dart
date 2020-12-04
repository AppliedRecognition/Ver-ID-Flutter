class Bearing {
  final _value;
  const Bearing._internal(this._value);
  toString() => 'Enum.$_value';

  static const STRAIGHT = const Bearing._internal('STRAIGHT');
  static const UP = const Bearing._internal('UP');
  static const RIGHT_UP = const Bearing._internal('RIGHT_UP');
  static const RIGHT = const Bearing._internal('RIGHT');
  static const RIGHT_DOWN = const Bearing._internal('RIGHT_DOWN');
  static const DOWN = const Bearing._internal('DOWN');
  static const LEFT_DOWN = const Bearing._internal('LEFT_DOWN');
  static const LEFT = const Bearing._internal('LEFT');
  static const LEFT_UP = const Bearing._internal('LEFT_UP');
}
