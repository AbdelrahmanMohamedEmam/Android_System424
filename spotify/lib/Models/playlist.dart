import 'package:flutter/foundation.dart';
import './tracks_in_playlist.dart';
import './owner.dart';
import './external_url.dart';
import './image.dart';
import '../utilities.dart';

class Playlist with ChangeNotifier {
  final bool collaborative;
  final String description;
  final List<ExternalUrl> externalUrls;
  final String href;
  final String id;
  final List<Image> images;
  final String name;
  final List<Owner> owner;
  final bool public;
  final String snapShotId;
  final TracksInPlaylist tracks;
  final String type;
  final String uri;

  Playlist({
    this.collaborative,
    this.description,
    this.externalUrls,
    this.href,
    this.id,
    this.images,
    this.name,
    this.owner,
    this.public,
    this.snapShotId,
    this.tracks,
    this.type,
    this.uri,
  });
  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      collaborative: json['collaborative'],
      description: json['description'],
      externalUrls: parceExternalUrl(json['externalUrls']),
      href: json['href'],
      id: json['id'],
      images: parceImage(json['images']),
      name: json['name'],
      owner: parceOwner(json['owner']),
      public: json['public'],
      snapShotId: json['snapshot_id'],
      tracks: TracksInPlaylist.fromJson(json['tracks']),
      type: json['type'],
      uri: json['uri'],
    );
  }
}
