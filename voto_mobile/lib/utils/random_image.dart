import 'dart:math';

class RandomImage {
  static int min = 1;
  static int max = 8;
  static String slug = 'misc';
  static String filetype = 'jpg';

  /// Get random placeholder image from Firebase Storage

  static String get() {
    final int _random = Random().nextInt(max) + min;
    return 'gs://cs21-voto.appspot.com/dummy/$slug$_random.$filetype';
  }
}