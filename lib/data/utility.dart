import 'package:finance/data/model/add_date.dart';
import 'package:hive/hive.dart';

int totals = 0;

final box = Hive.box<Add_data>('data');

int total() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }

  totals = a.reduce((value, element) => value + element);
  return totals;
}

int income() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? int.parse(history2[i].amount) : 0);
  }

  totals = a.reduce((value, element) => value + element);
  return totals;
}

int expenses() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? 0 : int.parse(history2[i].amount) * -1);
  }

  totals = a.reduce((value, element) => value + element);
  return totals;
}

List<Add_data> today() {
  List<Add_data> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].dateTime.day == date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_data> week() {
  List<Add_data> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (date.day - 7 <= history2[i].dateTime.day &&
        history2[i].dateTime.day <= date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_data> month() {
  List<Add_data> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].dateTime.month == date.month) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_data> year() {
  List<Add_data> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].dateTime.year == date.year) {
      a.add(history2[i]);
    }
  }
  return a;
}

int totalChart(List<Add_data> history2) {
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }

  totals = a.reduce((value, element) => value + element);
  return totals;
}

List time(List<Add_data> history2, bool hour) {
  List<Add_data> a = [];
  List total = [0, 0];
  int counter = 0;

  for (var c = 0; c < history2.length; c++) {
    for (var i = c; i < history2.length; i++) {
      if (hour) {
        if (history2[i].dateTime.hour == history2[c].dateTime.hour) {
          a.add(history2[i]);
          counter = i;
        }
      } else {
        if (history2[i].dateTime.day == history2[c].dateTime.day) {
          a.add(history2[i]);
          counter = i;
        }
      }
    }
    total.add(totalChart(a));
    a.clear();
    c = counter;
  }
  return total;
}
