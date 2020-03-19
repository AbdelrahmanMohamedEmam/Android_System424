class TracksRef {
  final String href;
  final int total;
  TracksRef({
    this.href,
    this.total,
  });
  factory TracksRef.fromJson(Map<String, dynamic> json) {
    return TracksRef(
      href: json['href'],
      total: json['total'],
    );
  }
}
