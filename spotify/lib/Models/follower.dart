class Follower {
  final String href;
  final int total;
  Follower({
    this.href,
    this.total,
  });
  factory Follower.fromjson(Map<String, dynamic> json) {
    return Follower(
      href: json['href'] == null ? null : json['href'],
      total: json['total'] == null ? 0 : json['total'],
    );
  }
}
