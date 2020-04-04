import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/play_history.dart';
import 'package:spotify/Providers/play_history_provider.dart';

class RecentlyPlayedArtistsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playHistory =
        Provider.of<PlayHistoryProvider>(context, listen: false);
    final List<PlayHistory> recentlyPlayedArtists =
        playHistory.getRecentlyPlayedArtists;
    return Scaffold(
      backgroundColor: Color.fromRGBO(48, 44, 44, 1),
      appBar: AppBar(
        title: Text('Recently played artists'),
        backgroundColor: Color.fromRGBO(48, 44, 44, 1),
      ),
      body: ListView.builder(
        itemCount: recentlyPlayedArtists.length,
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
          value: recentlyPlayedArtists[i],
          child: ListTileArtist(),
        ),
      ),
    );
  }
}

class ListTileArtist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recentlyPlayedArtist =
        Provider.of<PlayHistory>(context, listen: false);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(recentlyPlayedArtist.context.image),
      ),
      title: Text(
        recentlyPlayedArtist.context.name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
