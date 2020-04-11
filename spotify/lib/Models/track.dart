import 'package:flutter/material.dart';
import 'package:spotify/Models/album.dart';
import '../Models/external_url.dart';
import '../Models/external_id.dart';
import '../Models/artist.dart';
import '../utilities.dart';



///A model for grouping the track data.
///Constructor for class Track with named arguments assignment.
///Required parameters:{href,id,name,uri}.

class Track with ChangeNotifier {

  ///A string describing artist's name.
  final String name;

  ///Base 62-identifier of this object (artist){required}.
  final String id;

  ///Album object of the album that the track belongs to.
  final Album album;

  ///Index ofm track in the list of tracks (album).
  final int trackNumber;

  ///Artist object of the Artist that the track belongs to.
  final List<Artist> artists;

  ///Track type ex :"sha3bi , pop , house"
  final String type;

  ///integer number determines Track duration in milliseconds.
  final int durationMs;

  ///List of external IDs
  final List<ExternalId> externalIds;

  ///An list of objects containing  the url and its type of the object.
  final List<ExternalUrl> externalUrls;

  ///A string describing the spotify uri for this artist{required}.
  final String uri;

  ///A link to the web api end point providing all details of this artist{required}.
  final String href;

  ///Integer number indicates Track popularity.
  final int popularity;


  ///A constructor with named parameters.
  ///Constructor for class Artist with named arguments assignment.
  ///Required parameters:{href,id,name,artistInfo,uri}.

  Track({
    ///Initializations.
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
  ///A method that parses a mapped object from a json file and returns a Track object.
  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      name: json['name'],
      id: json['_id'],
      album: Album.fromJson(json['album']),
      trackNumber: json['trackNumber'],
      artists: parceArtist(json['artists']),
      type: json['type'],
      durationMs: json['durationMs'],
      externalUrls: parceExternalUrl(json['externalUrls']),
      uri: json['uri'],
      href: json['href'],
      popularity: json['popularity'],
    );
  }
}
