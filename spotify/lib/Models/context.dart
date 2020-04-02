import 'package:spotify/Models/external_url.dart';
import '../utilities.dart';

class Context {
  final String type;
  final String href;
  final String uri;
  final List<ExternalUrl> externalUrls;
  Context({
    this.type,
    this.href,
    this.uri,
    this.externalUrls,
  });
  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      type: json['type'],
      href: json['href'],
      uri: json['uri'],
      externalUrls: parceExternalUrl(json['externalUrls']),
    );
  }
}
