import 'package:flutter/material.dart';

import '../Models/external_url.dart';
import '../Models/external_id.dart';
import '../Models/artist.dart';

import '../utilities.dart';

class Track with ChangeNotifier{
  final String name;
  final String id;
  final String album;
  final int trackNumber;
  final List<Artist> artists;
  final String type;
  final bool isLocal;
  final int durationMs;
  final List<ExternalId> externalIds;
  final List<ExternalUrl> externalUrls;
  final String uri;
  final String href;
  final String previewUrl;
  final int popularity;
  final String imgUrl;
  Track({
    this.name,
    this.id,
    this.album,
    this.trackNumber,
    this.artists,
    this.type,
    this.isLocal,
    this.durationMs,
    this.externalIds,
    this.externalUrls,
    this.uri,
    this.href,
    this.previewUrl,
    this.popularity,
    this.imgUrl,
  });
  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      name: json['name'],
      id: json['id'],
      album: json['album'],
      trackNumber: json['trackNumber'],
      artists: parceArtist(json['artists']),
      type: json['type'],
      isLocal: json['isLocal'],
      durationMs: json['durationMs'],
      externalIds: parceExternalId(json['externalIds']),
      externalUrls:
      parceExternalUrl(json['externalUrls']),
      uri: json['uri'],
      href: json['href'],
      previewUrl: json['previewUrl'],
      popularity: json['popularity'],
      imgUrl: json['imageUrl']
    );
  }
  factory Track.fromJson2(Map<String,dynamic> json)
  {
    return Track(
      imgUrl: json['imageUrl'],
      name: json['name'],
      id: json['id'],
    );
  }
}
