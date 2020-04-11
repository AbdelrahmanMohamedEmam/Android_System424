import 'package:flutter/material.dart';
import './context.dart';

///Class PlayHistory to describe the playHistory object.
class PlayHistory with ChangeNotifier {
  //final Track track;

  ///String describes the time this track has been played at.
  final String playedAt;

  ///Context object for this playhistory.
  final Context context;

  ///Constructor for class owner with named arguments assignment.
  PlayHistory({
    this.playedAt,
    this.context,
  });

  ///A method that parses a mapped object from a json file and returns an PlayHistory object.
  factory PlayHistory.fromJson(Map<String, dynamic> json) {
    return PlayHistory(
      playedAt: json['playedAt'],
      context: Context.fromJson(json['context']),
    );
  }
}
