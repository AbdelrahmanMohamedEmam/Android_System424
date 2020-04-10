///Class Image that describes the image object.
class Image {
  ///The link to the image.
  final String url;

  ///Constructor for class Image with named arguments assignment.
  Image({
    this.url,
  });

  ///A method that parses a mapped object from a json file and returns an Image object.
  factory Image.fromjson(Map<String, dynamic> json) {
    return Image(
      url: json['url'],
    );
  }
}
