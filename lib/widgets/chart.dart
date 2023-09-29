// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:finance/data/model/add_date.dart';
import 'package:finance/data/utility.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final int indexNew;
  const Chart({
    Key? key,
    required this.indexNew,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<AddData>? a;
  bool b = true;
  bool j = true;
  @override
  Widget build(BuildContext context) {
    switch (widget.indexNew) {
      case 0:
        a = today();
        b = true;
        j = true;
        break;
      case 1:
        a = week();
        b = false;
        j = true;
        break;
      case 2:
        a = month();
        b = false;
        j = true;
        break;
      case 3:
        a = year();
        j = false;
        break;
      default:
    }
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <SplineSeries<SalesData, String>>[
          SplineSeries<SalesData, String>(
            color: const Color.fromARGB(255, 47, 125, 121),
            width: 3,
            dataSource: <SalesData>[
              ...List.generate(time(a!, b ? true : false).length.compareTo(0),
                  (index) {
                return SalesData(
                    j
                        ? b
                            ? a![index].dateTime.hour.toString()
                            : a![index].dateTime.day.toString()
                        : a![index].dateTime.month.toString(),
                    b
                        ? index > 0
                            ? time(a!, true)[index] + time(a!, true)[index - 1]
                            : time(a!, true)[index]
                        : index > 0
                            ? time(a!, false)[index] +
                                time(a!, false)[index - 1]
                            : time(a!, false)[index]);
              }),
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final int sales;
}
