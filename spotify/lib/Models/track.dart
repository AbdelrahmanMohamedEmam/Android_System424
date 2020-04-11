import 'package:flutter/material.dart';
import 'package:spotify/Models/album.dart';

import '../Models/external_url.dart';
import '../Models/external_id.dart';
import '../Models/artist.dart';

import '../utilities.dart';


///A model for grouping the track data.
class Track with ChangeNotifier {
  final String name;
  final String id;
  final Album album;
  final int trackNumber;
  final List<Artist> artists;
  final String type;
  final int durationMs;
  final List<ExternalId> externalIds;
  final List<ExternalUrl> externalUrls;
  final String uri;
  final String href;
  final int popularity;

  ///A constructor with named parameters.
  Track({
    this.name,
    this.id,
    this.album,
    this.trackNumber,
    this.artists,
    this.type,
    this.durationMs,
    this.externalIds,
    this.externalUrls,
    this.uri,
    this.href,
    this.popularity,
  });


  ///A factory method to decode the Json user into a track object.
  ///Check if the object is received first in the request to avoid errors.
  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      name: json['name'],
      id: json['_id'],
      album: Album.fromJson(json['album']),
      trackNumber: json['trackNumber'],
      artists: parceArtist(json['artists']),
      type: json['type'],
      durationMs: json['durationMs'],
      //externalIds: parceExternalId(json['externalIds']),
      externalUrls: parceExternalUrl(json['externalUrls']),
      uri: json['uri'],
      href: json['href'],
      popularity: json['popularity'],
    );
  }
  /*
  factory Track.fromJsonAlbum(Map<String, dynamic> json) {
    return Track(
      name: json['name'],
      id: json['_id'],
     // album: json['album'],
     album: Album.fromJson(json['album']),
      trackNumber: json['trackNumber'],
      //artists: parceArtist(json['artists']),
      type: json['type'],
      durationMs: json['durationMs'],
      //externalIds: parceExternalId(json['externalIds']),
      externalUrls: parceExternalUrl(json['externalUrls']),
      uri: json['uri'],
      href: json['href'],
      popularity: json['popularity'],
    );
<<<<<<< HEAD
  }*/

}
