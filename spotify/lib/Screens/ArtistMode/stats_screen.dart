import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotify/Models/chart_data.dart';


class StatsScreen extends StatefulWidget {
  final chart;
  final bar;
  final bar2;
  final line;
  final line2;
  final name;
  StatsScreen({this.chart, this.bar , this.bar2 ,this.line , this.line2 , this.name});

  ///route name to get to the screen from navigator.
  static const routeName = '//stats_screen';

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
///variable to store fetched data to be displayed on charts

  bool _isInit = false;
  bool _isLoading = false;

  List<charts.Series<ChartData, String>> _seriesData;
  List<charts.Series<ChartData, int>> _seriesPieData;
  List<charts.Series<ChartData, int>> _seriesLineData;

  _generateData() {
    var data1 = widget.bar;
    var data2 =widget.bar2;

    var piedata = widget.chart;

    var linesalesdata = widget.line;

    var linesalesdata1 = widget.line2;

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
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.green),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (ChartData ch, _) => ch.label,
        measureFn: (ChartData ch, _) => ch.value,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.red),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (ChartData ch, _) => ch.label,
        measureFn: (ChartData ch, _) => ch.value,
      ),
    );
  }

  //bool _isInit = false;
  //bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    _seriesData = List<charts.Series<ChartData, String>>();
    _seriesPieData = List<charts.Series<ChartData, int>>();
    _seriesLineData = List<charts.Series<ChartData, int>>();
    _generateData();
  }


  @override
  Widget build(BuildContext context) {
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
        :DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[700],
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
            title: Text(widget.name),
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
                            'Number of listeners and likes of ' + widget.name + ' in last year',style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold),),
                          Expanded(
                            child: charts.BarChart(
                              _seriesData,
                              animate: true,
                              barGroupingType: charts.BarGroupingType.grouped,
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
                            'Number of listeners of ' + widget.name + ' over years',style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold),),
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
                            'Number of listeners and likes of ' + widget.name + ' in last month',style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold),),
                         Expanded(
                            child: charts.LineChart(
                                _seriesLineData,
                                defaultRenderer: new charts.LineRendererConfig(
                                    includeArea: true, stacked: true),
                                animate: true,
                                animationDuration: Duration(seconds: 5),
                                behaviors: [
                                  new charts.ChartTitle('Days',
                                      behaviorPosition: charts.BehaviorPosition.bottom,
                                      titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                                  new charts.ChartTitle('listeners and likes',
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
    );
  }
}
