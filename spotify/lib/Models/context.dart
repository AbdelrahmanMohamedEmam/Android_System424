//Import model files.
import 'package:spotify/Models/external_url.dart';

///Context object to identify the [PlayHistory] object [Artist],[Album],[Playlist].
class Context {
  ///Identifier to the type of the context sent, ex:"artist","album","playlist".
  final String type;

  ///A link to the web api end point providing all details of this context.
  final String href;

  ///The spotify uri for this context.
  final String uri;

  // final List<ExternalUrl> externalUrls;

  ///A String url to an image for this context object.
  final String image;

  ///The name of the context sent according to its type.
  final String name;

  ///Constructor for class album with named arguments assignment.
  Context({
    this.type,
    this.href,
    this.uri,
    //this.externalUrls,
    this.image,
    this.name,
  });

  ///A method that parses a mapped object from a json file and returns an context object.
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
