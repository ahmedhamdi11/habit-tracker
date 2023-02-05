import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/date_time/date_time.dart';
class MonthSummary extends StatelessWidget {

  final Map<DateTime,int>? dataSets;
  final String startDate;

  const MonthSummary({
    super.key,
    required this.dataSets,
    required this.startDate,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(top: 25,bottom: 25),
      child: HeatMap(
        startDate:createDateTimeToObject(startDate),
        endDate:DateTime.now().add(Duration(days: 0)),
        datasets: dataSets,
        colorMode: ColorMode.color,
        defaultColor:Colors.grey[200],
        textColor:Colors.white,
        showText: true,
        scrollable: true,
        showColorTip:false,
        size:30,
        colorsets: const{
          1: Color.fromARGB(20, 2, 179, 8),
          2: Color.fromARGB(40, 2, 179, 8),
          3: Color.fromARGB(60, 2, 179, 8),
          4: Color.fromARGB(80, 2, 179, 8),
          5: Color.fromARGB(100, 2, 179, 8),
          6: Color.fromARGB(120, 2, 179, 8),
          7: Color.fromARGB(140, 2, 179, 8),
          8: Color.fromARGB(160, 2, 179, 8),
          9: Color.fromARGB(180, 2, 179, 8),
          10: Color.fromARGB(200, 2, 179, 8),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
