
import './external_url.dart';
//need to import something for followers
//need to import something for genres
import './image.dart';

class Artist {
  final List<ExternalUrl> externalUrls;
  //final List<Followers> followers;
  //final List<Genres> genres;
  final String href;
  final String id;
  final List<Image> images;
  final String name;
  final int popularity;
  final String type;
  final String uri;


  Artist({
    this.externalUrls ,
    //this.followers ,
    //this.genres ,
    this.href ,
    this.id,
    this.images,
    this.name ,
    this.popularity ,
    this.type ,
    this.uri ,
  });
}
