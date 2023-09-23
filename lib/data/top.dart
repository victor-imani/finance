import 'package:finance/data/1.dart';

List<money> geterTop() {
  money snapFood = money();
  snapFood.time = 'Jan 20, 2023';
  snapFood.image = 'Food.png';
  snapFood.buy = true;
  snapFood.fee = '- \$ 100';
  snapFood.name = 'Snap Food';

  money snap = money();
  snap.image = 'Transfer.png';
  snap.time = 'Today';
  snap.buy = true;
  snap.fee = '- \$ 60';
  snap.name = 'Transfer';

  return [snapFood, snap];
}
