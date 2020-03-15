class ExternalUrl {
  /// Type of the url that the object has
  final String type;

  /// The external public url to the object
  final String url;
  
  ExternalUrl({
    this.type,
    this.url,
  });
  factory ExternalUrl.fromjson(Map<String, dynamic> json) {
    return ExternalUrl(
      type: json['type'],
      url: json['url'],
    );
  }
}
