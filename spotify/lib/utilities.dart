import './Models/external_url.dart';
import './Models/follower.dart';
import './Models/image.dart';
import './Models/owner.dart';
import './Models/playlist.dart';
import './Models/copyright.dart';

List<Image> parceImage(imageJason) {
  var list = imageJason as List;
  List<Image> imageList = list.map((data) => Image.fromjson(data)).toList();
  return imageList;
}

List<ExternalUrl> parceExternalUrl(externalUrlJason) {
  var list = externalUrlJason as List;
  List<ExternalUrl> externalUrlList =
      list.map((data) => ExternalUrl.fromjson(data)).toList();
  return externalUrlList;
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

<<<<<<< HEAD
List<Copyright> parceCopyright(copyrightJson) {
  var list = copyrightJson as List;
  List<Copyright> copyrightList =
      list.map((data) => Copyright.fromjson(data)).toList();
  return list;
}
=======

>>>>>>> 96e8e9c54af009d9015342ae9d5f5264e5dfb20d
