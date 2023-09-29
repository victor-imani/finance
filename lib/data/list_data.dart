import 'one.dart';

List<Money> geter() {
  Money upwork = Money();
  upwork.name = 'Upwork';
  upwork.fee = '650';
  upwork.time = 'Today';
  upwork.image = 'up.png';
  upwork.buy = false;

  Money starBucks = Money();
  starBucks.buy = true;
  starBucks.fee = '15';
  starBucks.image = 'Star.png';
  starBucks.name = 'StarBucks';
  starBucks.time = 'Today';

  Money transfer = Money();
  transfer.buy = true;
  transfer.fee = '100';
  transfer.image = 'Transfer.png';
  transfer.name = 'Transfer for Sam';
  transfer.time = 'Jan 30, 2023';

  return [
    upwork,
    starBucks,
    transfer,
    upwork,
    starBucks,
    transfer,
  ];
}
