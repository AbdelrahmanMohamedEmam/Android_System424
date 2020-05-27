//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Importing API provider.
import 'package:spotify/API_Providers/albumAPI.dart';
import 'package:spotify/Models/chart_data.dart';

//Import Models.
import '../Models/charts.dart';


///Class AlbumProvider
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
  List<ChartData>  get fetchedBarData {
    return _fetchedBarData;
  }
  List<ChartData>  get fetchedBarData2 {
    return _fetchedBarData2;
  }

  List<ChartData>  get fetchedLineData {
    return _fetchedLineData;
  }
  List<ChartData>  get fetchedLineData2 {
    return _fetchedLineData2;
  }
  ///A method that fetches for charts data.
  ///It requires a parameter of type [String] token to verify the user.
  Future<void> fetchChartData() async {
    final url = 'http://www.mocky.io/v2/5ecece023200002500e3cdaa';
    final response = await http.get(url);
    Map<String, dynamic> temp = json.decode(response.body);
  //  print(temp);

    final extractedList = temp['chartData'] as List;
//print(extractedList);
    final List<ChartData> loadedCharts = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedCharts.add(ChartData.fromJson(extractedList[i]));
    }
    _fetchedData = loadedCharts;
    notifyListeners();
    //print(extractedList);
    //return _fetchedData;
  }

  Future<void> fetchBarChartData() async {
    final url = 'http://www.mocky.io/v2/5ecece923200005700e3cdb1';
    final response = await http.get(url);
    Map<String, dynamic> temp = json.decode(response.body);
    //  print(temp);

    final extractedList = temp['chartData'] as List;
//print(extractedList);
    final List<ChartData> loadedCharts = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedCharts.add(ChartData.fromJson(extractedList[i]));
    }
    _fetchedBarData = loadedCharts;
    notifyListeners();
    print(extractedList);
    //return _fetchedData;
  }


  Future<void> fetchBarChartData2() async {
    final url = 'http://www.mocky.io/v2/5ececd833200000e00e3cd8e';
    final response = await http.get(url);
    Map<String, dynamic> temp = json.decode(response.body);
    //  print(temp);

    final extractedList = temp['chartData'] as List;
//print(extractedList);
    final List<ChartData> loadedCharts = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedCharts.add(ChartData.fromJson(extractedList[i]));
    }
    _fetchedBarData2 = loadedCharts;
    notifyListeners();
    //print(extractedList);
    //return _fetchedData;
  }

  Future<void> fetchLineChartData() async {
    final url = 'http://www.mocky.io/v2/5ecede873200004f00e3ce10';
    final response = await http.get(url);
    Map<String, dynamic> temp = json.decode(response.body);
    //  print(temp);

    final extractedList = temp['chartData'] as List;
//print(extractedList);
    final List<ChartData> loadedCharts = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedCharts.add(ChartData.fromJson(extractedList[i]));
    }
    _fetchedLineData = loadedCharts;
    notifyListeners();
    //print(extractedList);
    //return _fetchedData;
  }


  Future<void> fetchLineChartData2() async {
    final url = 'http://www.mocky.io/v2/5ecede5a3200005800e3ce0e';
    final response = await http.get(url);
    Map<String, dynamic> temp = json.decode(response.body);
     print(temp);

    final extractedList = temp['chartData'] as List;
print(extractedList);
    final List<ChartData> loadedCharts = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedCharts.add(ChartData.fromJson(extractedList[i]));
    }
    _fetchedLineData2 = loadedCharts;
    //print(_fetchedLineData2[0].value);
    notifyListeners();
    //print(extractedList);
    //return _fetchedData;
  }

}