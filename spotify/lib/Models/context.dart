import 'package:spotify/Models/external_url.dart';
import '../utilities.dart';

class Context {
  final String type;
  final String href;
  final String uri;
  final List<ExternalUrl> externalUrls;
  final String image;
  final String name;
  Context({
    this.type,
    this.href,
    this.uri,
    this.externalUrls,
    this.image,
    this.name,
  });
  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      type: json['type'],
      href: json['href'],
      uri: json['uri'],
      //externalUrls: parceExternalUrl(json['externalUrls']),
      image: json['image'],
      name: json['name'],
    );
  }
}
