import 'package:reversible_random/reversible_random.dart';

void main() {
  var rd = ReversibleRandom();
  print('${rd.range}');
  print('${rd.current()}');
  print('${rd.next(max: 20)}');
  print('${rd.next(max: 20)}');
  print('${rd.next(max: 20)}');
  print('${rd.next(max: 20)}');
  print('${rd.next(max: 20)}');
  print('${rd.next(max: 20)}');
  print('${rd.next(max: 20)}');
  print('${rd.next(max: 20)}');
  print('${rd.previous(max: 20)}');
  print('${rd.previous(max: 20)}');
  print('${rd.previous(max: 20)}');
  print('${rd.previous(max: 20)}');
  print('${rd.previous(max: 20)}');
  print('${rd.previous(max: 20)}');
  print('${rd.previous(max: 20)}');
  print('${rd.previous()}');
}
