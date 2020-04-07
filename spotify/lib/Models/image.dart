class Image {
  final String url;
  Image({
    this.url,
  });
  factory Image.fromjson(Map<String, dynamic> json) {
    return Image(
      url: json['url'],
    );
  }
}
