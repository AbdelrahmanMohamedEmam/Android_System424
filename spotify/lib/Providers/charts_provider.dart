//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spotify/Models/chart_data.dart';



///Class ChartsProvider
class ChartsProvider with ChangeNotifier {

  List<ChartData> _fetchedData;
  List<ChartData> _fetchedBarData;
  List<ChartData> _fetchedBarData2;
  List<ChartData> _fetchedLineData;
  List<ChartData> _fetchedLineData2;

  ///A method(getter) that returns a chart data.
  List<ChartData>  get fetchedData {
    return _fetchedData;
  }
  ///A method(getter) that returns a chart data.
  List<ChartData>  get fetchedBarData {
    return _fetchedBarData;
  }
  ///A method(getter) that returns a chart data.
  List<ChartData>  get fetchedBarData2 {
    return _fetchedBarData2;
  }
  ///A method(getter) that returns a chart data.
  List<ChartData>  get fetchedLineData {
    return _fetchedLineData;
  }
  ///A method(getter) that returns a chart data.
  List<ChartData>  get fetchedLineData2 {
    return _fetchedLineData2;
  }
  ///A method that fetches for charts data.
  ///It requires a parameter of type [String] token to verify the user.
  Future<void> fetchChartData() async {
    final url = 'http://www.mocky.io/v2/5ecece023200002500e3cdaa';
    final response = await http.get(url);
    Map<String, dynamic> temp = json.decode(response.body);

    final extractedList = temp['chartData'] as List;
    final List<ChartData> loadedCharts = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedCharts.add(ChartData.fromJson(extractedList[i]));
    }
    _fetchedData = loadedCharts;
    notifyListeners();
  }
  ///A method that fetches for charts data.
  Future<void> fetchBarChartData() async {
    final url = 'http://www.mocky.io/v2/5ecece923200005700e3cdb1';
    final response = await http.get(url);
    Map<String, dynamic> temp = json.decode(response.body);

    final extractedList = temp['chartData'] as List;
    final List<ChartData> loadedCharts = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedCharts.add(ChartData.fromJson(extractedList[i]));
    }
    _fetchedBarData = loadedCharts;
    notifyListeners();
  }

  ///A method that fetches for charts data.
  Future<void> fetchBarChartData2() async {
    final url = 'http://www.mocky.io/v2/5ececd833200000e00e3cd8e';
    final response = await http.get(url);
    Map<String, dynamic> temp = json.decode(response.body);

    final extractedList = temp['chartData'] as List;
    final List<ChartData> loadedCharts = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedCharts.add(ChartData.fromJson(extractedList[i]));
    }
    _fetchedBarData2 = loadedCharts;
    notifyListeners();
  }
  ///A method that fetches for charts data.
  Future<void> fetchLineChartData() async {
    final url = 'https://run.mocky.io/v3/0a6a2782-3bf5-47ab-ae79-48ac75c67695';
    final response = await http.get(url);
    Map<String, dynamic> temp = json.decode(response.body);

    final extractedList = temp['chartData'] as List;
    final List<ChartData> loadedCharts = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedCharts.add(ChartData.fromJson(extractedList[i]));
    }
    _fetchedLineData = loadedCharts;
    notifyListeners();
  }

  ///A method that fetches for charts data.
  Future<void> fetchLineChartData2() async {
    final url = 'https://run.mocky.io/v3/ca220283-75da-4c57-9bcf-c69abd489b38';
    final response = await http.get(url);
    Map<String, dynamic> temp = json.decode(response.body);

    final extractedList = temp['chartData'] as List;
    final List<ChartData> loadedCharts = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedCharts.add(ChartData.fromJson(extractedList[i]));
    }
    _fetchedLineData2 = loadedCharts;
    notifyListeners();
  }

}