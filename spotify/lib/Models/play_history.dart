import 'package:flutter/material.dart';

import './context.dart';

class PlayHistory with ChangeNotifier {
  //final Track track;
  final String playedAt;
  final Context context;
  PlayHistory({
    this.playedAt,
    this.context,
  });
  factory PlayHistory.fromJson(Map<String, dynamic> json) {
    return PlayHistory(
      playedAt: json['playedAt'],
      context: Context.fromJson(json['context']),
    );
  }
}
