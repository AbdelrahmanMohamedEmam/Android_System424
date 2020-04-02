//import packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/play_history.dart';
import 'package:spotify/widgets/play_history_item_widget.dart';
//import providers
import '../Providers/play_history_provider.dart';
//import widgets


class RecentlyPlayedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final playHistoryProvider = Provider.of<PlayHistoryProvider>(context);
    List<PlayHistory> playHistory;
    playHistory = playHistoryProvider.getRecentlyPlayed;

    return Container(
      height: (deviceSize.height) * 0.3880,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            height: ((deviceSize.height) * 0.4) * 0.14,
            width: double.infinity,
            margin: EdgeInsets.only(
              bottom: ((deviceSize.height) * 0.4) * 0.0357,
              left: deviceSize.width * 0.0244,
              top: ((deviceSize.height) * 0.4) * 0.0535,
            ),
            child: Text(
              'Recently played',
              style: TextStyle(
                color: Color.fromRGBO(196, 189, 187, 20),
                fontSize: deviceSize.width * 0.0609,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: (deviceSize.height) * 0.2929,
            child: ListView.builder(
              itemCount: playHistory.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: playHistory[i],
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: deviceSize.width * 0.0244,
                  ),
                  child: PlayHistoryWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
