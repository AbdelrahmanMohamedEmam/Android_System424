import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotify/Models/chart_data.dart';
import '../../Providers/charts_provider.dart';
import 'package:provider/provider.dart';
import '../../Models/charts.dart';


class StatsScreen extends StatefulWidget {
  //final Widget child;

  final chart;
  final bar;
  final bar2;
  final line;
  final line2;
  StatsScreen({this.chart, this.bar , this.bar2 ,this.line , this.line2});
  //StatsScreen({Key key, this.child}) : super(key: key);
  ///route name to get to the screen from navigator.
  static const routeName = '//stats_screen';

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
///variable to store fetched data to be displayed on charts
  //List <ChartData> fetched = widget.chart;

  bool _isInit = false;
  bool _isLoading = false;

  List<charts.Series<ChartData, String>> _seriesData;
  List<charts.Series<ChartData, int>> _seriesPieData;
  List<charts.Series<ChartData, int>> _seriesLineData;

  _generateData() {
    var data1 = widget.bar;
    var data2 =widget.bar2;
    //var data3 = widget.bar;

    var piedata = widget.chart;

    //var linesalesdata = [];//widget.line;
    print(widget.line);
    //print(widget.chart);
   //var linesalesdata1 =[]; //widget.line2;

    //var linesalesdata2 = widget.chart;

    _seriesData.add(
      charts.Series(
        domainFn: (ChartData ch, _) => ch.label,
        measureFn: (ChartData ch, _) => ch.value,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (_ , __) =>
          charts.ColorUtil.fromDartColor(Colors.green[200]),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (ChartData ch, _) => ch.label,
        measureFn: (ChartData ch, _) => ch.value,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (_ , __) =>
            charts.ColorUtil.fromDartColor(Colors.green[800]),
      ),
    );


    _seriesPieData.add(
      charts.Series(
        domainFn: (ChartData ch, _) => ch.label,
        measureFn: (ChartData ch, _) => ch.value,
        fillColorFn: (_ , __) =>
            charts.ColorUtil.fromDartColor(Colors.green[700]),
        id: 'Air Pollution',
        data: piedata,
        //labelAccessorFn: (ChartData chr, _) => '${chr.value}',
      ),
    );

   /* _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (ChartData ch, _) => ch.value,
        measureFn: (ChartData ch, _) => ch.label,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (ChartData ch, _) => ch.value,
        measureFn: (ChartData ch, _) => ch.label,

        //labelAccessorFn: (ChartData chr, _) => '${chr.value}',
      ),
    );*/
    /*_seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Air Pollution',
        data: linesalesdata2,
        domainFn: (ChartData ch, _) => ch.value,
        measureFn: (ChartData ch, _) => ch.label,
      ),
    );*/
  }

  //bool _isInit = false;
  //bool _isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<ChartData, String>>();
    _seriesPieData = List<charts.Series<ChartData, int>>();
    _seriesLineData = List<charts.Series<ChartData, int>>();
    _generateData();

  }


  @override
  Widget build(BuildContext context) {
    //final chartProvider =Provider.of<ChartsProvider>(context, listen: false);
    //fetched = chartProvider.fetchedData;
    //print(fetched[0].value);
    final deviceSize = MediaQuery.of(context).size;
    return _isLoading
        ? Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.green[700],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    )
        :  MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[700],
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Colors.green[700],
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.solidChartBar),
                ),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: Text('Statistics'),
          ),
          body: Container(
            color: Colors.black,
            height: deviceSize.height*0.75,
            child: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'number of likes and downloads per song',style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold),),
                          Expanded(
                            child: charts.BarChart(
                              _seriesData,
                              animate: true,
                              barGroupingType: charts.BarGroupingType.grouped,
                              //behaviors: [new charts.SeriesLegend()],
                              animationDuration: Duration(seconds: 5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Total number of followers over years',style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10.0,),
                          Expanded(
                            child: charts.PieChart(
                                _seriesPieData,
                                animate: true,
                                animationDuration: Duration(seconds: 5),
                                behaviors: [
                                  new charts.DatumLegend(
                                    outsideJustification: charts.OutsideJustification.endDrawArea,
                                    horizontalFirst: false,
                                    desiredMaxRows: 2,
                                    cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                                    entryTextStyle: charts.TextStyleSpec(
                                        color: charts.MaterialPalette.purple.shadeDefault,
                                        fontFamily: 'Georgia',
                                        fontSize: 11),
                                  )
                                ],
                                defaultRenderer: new charts.ArcRendererConfig(
                                    arcWidth: 100,
                                    arcRendererDecorators: [
                                      new charts.ArcLabelDecorator(
                                          labelPosition: charts.ArcLabelPosition.inside)
                                    ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Popuularity over years',style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold),),
                         Expanded(
                            child: charts.LineChart(
                                _seriesLineData,
                                defaultRenderer: new charts.LineRendererConfig(
                                    includeArea: true, stacked: true),
                                animate: true,
                                animationDuration: Duration(seconds: 5),
                                behaviors: [
                                  new charts.ChartTitle('Years',
                                      behaviorPosition: charts.BehaviorPosition.bottom,
                                      titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                                  new charts.ChartTitle('Popularity',
                                      behaviorPosition: charts.BehaviorPosition.start,
                                      titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}