//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:spotify/Models/chart_data.dart';
import '../utilities.dart';

///Album class that describes the album model that will be displayed.
class Chart with ChangeNotifier {
  ///array of the points to be displayed.
  List<ChartData> chartArr;

  ///Constructor for class Chart with named arguments assignment.
  Chart({
    ///Initializations.
    this.chartArr,
  });

  ///A method that parses a mapped object from a json file and returns an album object.
  factory Chart.fromJson(Map<String, dynamic> json) {
    return Chart(
      chartArr: parceChartData(json['ChartData']),

    );
  }
}
