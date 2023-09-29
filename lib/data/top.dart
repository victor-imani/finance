import 'package:finance/data/one.dart';

List<Money> geterTop() {
  Money snapFood = Money();
  snapFood.time = 'Jan 20, 2023';
  snapFood.image = 'Food.png';
  snapFood.buy = true;
  snapFood.fee = '- \$ 100';
  snapFood.name = 'Snap Food';

  Money snap = Money();
  snap.image = 'Transfer.png';
  snap.time = 'Today';
  snap.buy = true;
  snap.fee = '- \$ 60';
  snap.name = 'Transfer';

  return [snapFood, snap];
}
