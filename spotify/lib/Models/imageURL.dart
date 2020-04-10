///Class Image that describes the image object.
class ImageURL {
  ///The link to the image.
  final String url;

  ///Constructor for class Image with named arguments assignment.
  ImageURL({
    this.url,
  });

  ///A method that parses a mapped object from a json file and returns an Image object.
  factory ImageURL.fromjson(Map<String, dynamic> json) {
    return ImageURL(
      url: json['url'],
    );
  }
}
