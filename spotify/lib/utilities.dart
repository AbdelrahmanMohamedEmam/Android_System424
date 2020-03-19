import './Models/external_url.dart';
import './Models/follower.dart';
import './Models/image.dart';
import './Models/owner.dart';
import './Models/playlist.dart';
import './Models/copyright.dart';
import './Models/artist.dart';
import './Models/track.dart';
import './Models/external_id.dart';

List<Image> parceImage(imageJason) {
  var list = imageJason as List;
  List<Image> imageList = list.map((data) => Image.fromjson(data)).toList();
  return imageList;
}

List<ExternalUrl> parceExternalUrl(externalUrlJson) {
  var list = externalUrlJson as List;
  List<ExternalUrl> externalUrlList =
      list.map((data) => ExternalUrl.fromjson(data)).toList();
  return externalUrlList;
}

List<ExternalId> parceExternalId(externalIdJson) {
  var list = externalIdJson as List;
  List<ExternalId> externalIdList =
      list.map((data) => ExternalId.fromjson(data)).toList();
  return externalIdList;
}

List<Follower> parceFollower(followerJason) {
  var list = followerJason as List;
  List<Follower> followerList =
      list.map((data) => Follower.fromjson(data)).toList();
  return followerList;
}

List<Owner> parceOwner(ownerJson) {
  var list = ownerJson as List;
  List<Owner> ownerList = list.map((data) => Owner.fromjason(data)).toList();
  return ownerList;
}

List<Playlist> parcePlaylist(playlistJson) {
  var list = playlistJson as List;
  List<Playlist> playlistList =
      list.map((data) => Playlist.fromJson(data)).toList();
  return playlistList;
}

List<Copyright> parceCopyright(copyrightJson) {
  var list = copyrightJson as List;
  List<Copyright> copyrightList =
      list.map((data) => Copyright.fromjson(data)).toList();
  return copyrightList;
}

List<Artist> parceArtist(artistJson) {
  var list = artistJson as List;
  List<Artist> artistList = list.map((data) => Artist.fromJsonSimplified(data)).toList();
  return artistList;
}

List<Track> parceTrack(trackJson) {
  var list = trackJson as List;
  List<Track> trackList = list.map((data) => Track.fromJson(data)).toList();
  return trackList;
}
