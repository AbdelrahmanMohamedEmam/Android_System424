class ImageURL {
  final String url;
  ImageURL({
    this.url,
  });
  factory ImageURL.fromjson(Map<String, dynamic> json) {
    return ImageURL(
      url: json['url'],
    );
  }
}