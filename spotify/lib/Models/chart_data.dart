///Class ChartData that represents the stats to be displayed for artist
class ChartData {
  ///variable to store the lable x-axis of the chart
  final label;

  ///variable to store the value to be displayed
  final value;

  ///Constructor for class ChartData with named arguments assignment.
  ChartData({this.label, this.value});

  ///A method that parses a mapped object from a json file and returns a follower object.
  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(label: json['label'], value: json['value']);
  }
}
