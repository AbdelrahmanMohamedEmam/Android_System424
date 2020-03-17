import '../Models/external_url.dart';
import '../Models/external_id.dart';

class Track {
  final String name;
  final String id;
  //final String album;
  final int trackNumber;
  //final Artist ;
  final String type;
  final bool isLocal;
  final int durationMs;
  final List<ExternalUrl> externalIds;
  final List<ExternalId> externalUrls;
  final String uri;
  final String href;
  final String previewUrl;
  final int popularity;
  Track(
    this.name,
    this.id,
    //this.album
    this.trackNumber,
    //this.artist
    this.type,
    this.isLocal,
    this.durationMs,
    this.externalIds,
    this.externalUrls,
    this.uri,
    this.href,
    this.previewUrl,
    this.popularity,
  );
  //factory to be added
}
