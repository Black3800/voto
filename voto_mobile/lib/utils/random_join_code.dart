import 'dart:math';

class RandomJoinCode {
  static String get() {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    const _length = 6;
    final Random _rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        _length,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))
      )
    ); 
  }
}