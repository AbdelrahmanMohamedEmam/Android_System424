class Image {
  final int height;
  final int width;
  final String url;
  Image({
    this.height,
    this.width,
    this.url,
  });
  factory Image.fromjson(Map<String, dynamic> json) {
    return Image(
      height: json['height'],
      width: json['width'],
      url: json['url'],
    );
  }
}
