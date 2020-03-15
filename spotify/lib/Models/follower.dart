class Follower {
  final String href;
  final int total;
  Follower({
    this.href,
    this.total,
  });
  factory Follower.fromjson(Map<String, dynamic> json) {
    return Follower(
      href: json['href'],
      total: json['total'],
    );
  }
}
