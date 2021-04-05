# reversible_random.dart

A "reversible" random number generator package for Dart. It's able to generate the previous random number. Based on linear congruence.

Ported from [LovEveRv/reversible-random.js](https://github.com/LovEveRv/reversible-random.js).

一个Dart编写的“可逆”随机数生成器，能够生成前一个随机数。基于线性同余算法。

移植自[LovEveRv/reversible-random.js](https://github.com/LovEveRv/reversible-random.js).

## Usage

A simple usage example:

```dart
import 'package:reversible_random/reversible_random.dart';

main() {
  var rd = new ReversibleRandom();
  print('${rd.next(max: 20)}');
}
```
