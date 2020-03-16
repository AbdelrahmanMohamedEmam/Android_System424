class TracksInPlaylist {
  final String href;
  final int total;
  TracksInPlaylist({
    this.href,
    this.total,
  });
  factory TracksInPlaylist.fromJson(Map<String, dynamic> json) {
    return TracksInPlaylist(
      href: json['href'],
      total: json['total'],
    );
  }
}
