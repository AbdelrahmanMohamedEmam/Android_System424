import 'package:spotify/Models/external_url.dart';

import '../Models/artist.dart';
import '../Models/copyright.dart';
import './track.dart';
import './image.dart';

class Album {
  final String albumType;
  final List<Artist> artists;
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
  final List<Track> tracks;
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
}
