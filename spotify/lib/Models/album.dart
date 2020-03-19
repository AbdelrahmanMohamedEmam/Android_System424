import 'package:spotify/Models/external_url.dart';
import 'package:flutter/foundation.dart';
import 'package:spotify/Models/tracks_ref.dart';

import '../utilities.dart';
import '../Models/copyright.dart';
import './image.dart';

class Album with ChangeNotifier {
  final String albumType;
  final String artists;
  final List<Copyright> copyright;
  final ExternalUrl externalUrl;
  final List<String> genres;
  final String href;
  final String id;
  final List<Image> images;
  final String label;
  final String name;
  final int popularity;
  final String releaseDate;
  final TracksRef tracks;
  final String type;
  final String uri;
  Album({
    this.albumType,
    this.artists,
    this.copyright,
    this.externalUrl,
    this.genres,
    this.href,
    this.id,
    this.images,
    this.label,
    this.name,
    this.popularity,
    this.releaseDate,
    this.tracks,
    this.type,
    this.uri,
  });
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      albumType: json['albumType'],
      artists: json['artists'],
      copyright: parceCopyright(json['copyrights']),
      externalUrl: ExternalUrl.fromjson(json['externalUrls']),
      genres: json['genres'],
      href: json['href'],
      id: json['id'],
      images: parceImage(json['images']),
      label: json['label'],
      name: json['name'],
      popularity: json['popularity'],
      releaseDate: json['releaseDate'],
      tracks: TracksRef.fromJson(json['tracks']),
      type: json['type'],
      uri: json['uri'],
    );
  }
}
