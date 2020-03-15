class ExternalUrl {
  final String type;
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
