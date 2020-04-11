
import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

/*class Task{
  String task;
  double taskVal;
  Color taskCol;


  Task(this.task , this.taskVal , this.taskCol);

}*/

class OverviewScreen extends StatefulWidget {
  ///route name to get to the screen from navigator.
  static const   routeName='/overview_screen';

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {

  /*List <charts.Series<Task , String>> _dataSeries = [];


  void _generateData(){
    var pieData= [
      new Task('work' , 39.8 , Colors.red) ,
      new Task('play' , 88.3 , Colors.green) ,
      new Task('study' , 196 , Colors.lightBlue) ,
      new Task('fuck' , 20 , Colors.yellowAccent) ,
      new Task('else' , 350 , Colors.purple) ,
    ];
    _dataSeries.add(
      charts.Series(
        data: pieData,
        domainFn: (Task task , _) => task.task,
        measureFn: (Task task , _) => task.taskVal,
        colorFn: (Task task , _) =>charts.ColorUtil.fromDartColor(task.taskCol),
        id: 'Daily Task',
        labelAccessorFn: (Task row , _) => '${row.taskVal}',
      ),
    );

  }
  String artistImage =
      "https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg";
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateData();
    _dataSeries = List <charts.Series<Task , String>>();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.black,
      title: Text('overview screen'),
    ),
    );
      /*(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('overview screen'),
      ),
      body:Container(
        height: 400,
        width: double.infinity,
        child: Column(
          //controller: ,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('Daily tasks' ,
                      style: TextStyle(fontSize: 20 ,
                      ),
                      ),
                      charts.PieChart(
                            _dataSeries,
                          animate: true,
                          animationDuration: Duration(seconds: 7),
                          behaviors: [
                            new charts.DatumLegend(
                              outsideJustification: charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                              cellPadding: EdgeInsets.all(4),
                              entryTextStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.purple.shadeDefault,
                              fontSize: 11
                              ),
                            ),
                          ],
                          defaultRenderer: new charts.ArcRendererConfig(
                            arcLength: 10,
                            arcRendererDecorators: [new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside,
                            ),
                            ],
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
*/
  }
}



