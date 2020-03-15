import './owner.dart';
import './external_url.dart';
import './image.dart';
import '../utilities.dart';
class Playlist {
  final bool collaborative;
  final String description;
  final List<ExternalUrl> externalUrls;
  final String href;
  final String id;
  final List<Image> images;
  final String name;
  final List<Owner> owner;
  Playlist({
    this.collaborative,
    this.description,
    this.externalUrls,
    this.href,
    this.id,
    this.images,
    this.name,
    this.owner,
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
    );
  }
}
