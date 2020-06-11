import 'package:spotify/Models/chart_data.dart';
import 'package:spotify/Models/user_stats.dart';

import './Models/tracks_ref.dart';
import './Models/external_url.dart';
import './Models/follower.dart';
import './Models/image.dart';
import './Models/owner.dart';
import './Models/playlist.dart';
import './Models/copyright.dart';
import './Models/artist.dart';
import './Models/track.dart';
import './Models/external_id.dart';
//import './Models/artistInfo.dart';

///Convert list of jason objects into list of images
List<Image> parceImage(imageJason) {
  var list = imageJason as List;
  List<Image> imageList = list.map((data) => Image.fromjson(data)).toList();
  return imageList;
}

///Convert list of jason objects into list of external Urls
List<ExternalUrl> parceExternalUrl(externalUrlJson) {
  var list = externalUrlJson as List;
  List<ExternalUrl> externalUrlList =
      list.map((data) => ExternalUrl.fromJson(data)).toList();
  return externalUrlList;
}

///Convert list of jason objects into list of external Ids
List<ExternalId> parceExternalId(externalIdJson) {
  var list = externalIdJson as List;
  List<ExternalId> externalIdList =
      list.map((data) => ExternalId.fromjson(data)).toList();
  return externalIdList;
}

///Convert list of jason objects into list of followers
List<Follower> parceFollower(followerJason) {
  var list = followerJason as List;
  List<Follower> followerList =
      list.map((data) => Follower.fromjson(data)).toList();
  return followerList;
}

///Convert list of jason objects into list of owners
List<Owner> parceOwner(ownerJson) {
  var list = ownerJson as List;
  List<Owner> ownerList = list.map((data) => Owner.fromJson(data)).toList();
  return ownerList;
}

///Convert list of jason objects into list of playlists
List<Playlist> parcePlaylist(playlistJson) {
  var list = playlistJson as List;
  List<Playlist> playlistList =
      list.map((data) => Playlist.fromJson(data)).toList();
  return playlistList;
}

///Convert list of jason objects into list of copyrights
List<Copyright> parceCopyright(copyrightJson) {
  var list = copyrightJson as List;
  List<Copyright> copyrightList =
      list.map((data) => Copyright.fromjson(data)).toList();
  return copyrightList;
}

///Convert list of jason objects into list of artists
List<Artist> parceArtist(artistJson) {
  var list = artistJson as List;
  List<Artist> artistList =
      list.map((data) => Artist.fromJson(data)).toList();
  return artistList;
}

///Convert list of jason objects into list of ChartData
List<ChartData> parceChartData(ChartJson) {
  var list = ChartJson as List;
  List<ChartData> charttList =
  list.map((data) => ChartData.fromJson(data)).toList();
  return charttList;
}

///Convert list of jason objects into list of tracks of playlist
List<Track> parceTrackPlaylists(trackJson) {
  var list = trackJson as List;
  List<Track> trackList = list.map((data) => Track.fromJson(data)).toList();
  return trackList;
}

///Convert list of jason objects into list of tracks of albums
List<Track> parceTrackAlbums(trackJson) {
  var list = trackJson as List;
  List<Track> trackList = list.map((data) => Track.fromJson(data)).toList();
  return trackList;
}

///Convert list of jason objects into list of user stats
List<UserStats> parceUserStats(userStatsJson) {
  var list = userStatsJson as List;
  List<UserStats> userStats =
      list.map((data) => UserStats.fromJson(data)).toList();
  return userStats;
}

///Convert list of jason objects into list of track ref
List<TracksRef> parceTrackRef(trackRefJson) {
  var list = trackRefJson as List;
  List<TracksRef> trackrefList =
      list.map((data) => TracksRef.fromJson(data)).toList();
  return trackrefList;
}

///Convert list of jason objects into list of strings
List<String> parseString(stringJson) {
  List<String> stringList = new List<String>.from(stringJson);
  return stringList;
}

///Convert list of jason objects into list of requests
List<dynamic> parseRequest(var json, String type) {
  Map<String, dynamic> dataMap = json.decode(json.body);
  Map<String, dynamic> dataMap2 = dataMap['data'];
  return dataMap2['$type'] as List;
}

/*List<ArtistInfo> parceArtistInfo(ArtistInfoJason) {
  var list = ArtistInfoJason as List;
  List<ArtistInfo> InfoList =
  list.map((data) => ArtistInfo.fromJson(data)).toList();
  return InfoList;
}*/


///Convert list of jason objects into list of strings
List<int> parseInt(stringJson) {
  List<int> imageList = new List<int>.from(stringJson);
  return imageList;
}
