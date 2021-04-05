import 'dart:math';

/// Reversible Random Number Generator
///
/// This random generator is based on Linear Congruence Algorithm.
/// Original implementation in JavaScript: https://github.com/LovEveRv/reversible-random.js
class ReversibleRandom {
  int _a;
  int _c;
  int _m;
  int _inv_a;

  Random _rd;
  int _current;

  /// the largest possible number this random generator can produce
  int get range => _m - 1;

  /// Create a reversible random number generator with optional parameters.
  ///
  /// If you manually provide [inv_a], make sure **IT IS** the inverses of [a] (mod [m]).
  /// Also make sure [a] and [m] are coprime numbers.
  /// Otherwise, there will not be a certain [inv_a], thus this RNG cannot work properly.
  ReversibleRandom({int a, int c, int m, int inv_a}) {
    // check and set a, c, and m
    if (a == null && c == null && m == null) {
      // a, c, m not set
      if (inv_a != null) {
        throw UnsupportedError(
            'The inverse of a can not be set without setting a, c, and m first.');
      } else {
        _a = 48271;
        _c = 0;
        _m = 2147483647;
      }
    } else if (a == null || c == null || m == null) {
      // a, c, m not complete set
      throw UnsupportedError('a, c, and m should be set altogether.');
    } else {
      _a = a;
      _c = c;
      _m = m;
    }

    // check inverse of a
    if (inv_a != null) {
      _inv_a = inv_a;
      if (_a * _inv_a % _m != 1) {
        throw UnsupportedError(
            'The provided inverse of a is not the inverses of a (mod m).');
      }
    } else {
      _inv_a = _getInverse(_a, _m);
      if (_a * _inv_a % _m != 1) {
        throw UnsupportedError('The provided a and m are not coprime.');
      }
    }

    _rd = Random();
    reset();
  }

  /// Reset the initial value of this RNG. This is equal to something like
  /// ```dart
  /// var rand = new ReversibleRandom()
  /// ```
  /// except that you don't need to create another instance.
  void reset() {
    _current = _rd.nextInt(_m);
  }

  /// Set initial number between [min] (inclusive) and [max] (exclusive).
  ///
  /// The default range is [0, `ReversibleRandom.range`)
  void setInitial(int i, {int min = 0, int max}) {
    max ??= range;

    if (min >= max) {
      throw UnsupportedError('Provided range is illegal.');
    }
    if (i < min || i >= max) {
      throw UnsupportedError('Initial number i exceeds [min, max).');
    }

    _current = _rd.nextInt(_m ~/ (max - min)) * (max - min) + i - min;
  }

  /// Returns next pseudorandom Long between [min] (inclusive) and [max] (exclusive).
  ///
  /// The default range is [0, `ReversibleRandom.range`)
  int next({int min = 0, int max}) {
    max ??= range;
    if (min >= max) {
      throw UnsupportedError('Provided range is illegal.');
    }

    _current = (_current * _a + _c) % _m;
    return current(min: min, max: max);
  }

  /// Returns previous pseudorandom Long between [min] (inclusive) and [max] (exclusive).
  ///
  /// The default range is [0, `ReversibleRandom.range`)
  int previous({int min = 0, int max}) {
    max ??= range;
    if (min >= max) {
      throw UnsupportedError('Provided range is illegal.');
    }

    _current = ((_current + _m - _c) % _m) * _inv_a % _m;
    return current(min: min, max: max);
  }

  /// Returns current pseudorandom Long between [min] (inclusive) and [max] (exclusive).
  ///
  /// The default range is [0, `ReversibleRandom.range`)
  int current({int min = 0, int max}) {
    max ??= range;
    if (min >= max) {
      throw UnsupportedError('Provided range is illegal.');
    }

    return _current % (max - min) + min;
  }

  /// Find the inverses of [a] (mod [n]) using Extended Euclidean Algorithm.
  /// That is, find x s.t. [a] * x % [n] = 1.
  int _getInverse(int a, int n) {
    var qList = <int>[];
    while (n != 0) {
      qList.add(a ~/ n);
      var tmp = n;
      n = a % n;
      a = tmp;
    }
    var x = 1;
    var y = 0;
    while (qList.isNotEmpty) {
      var q = qList.removeLast();
      var tmp = a;
      a = a * q + n;
      n = tmp;
      tmp = y;
      y = (x - (a ~/ n) * y);
      x = tmp;
    }

    return (x % n + n) % n;
  }
}
