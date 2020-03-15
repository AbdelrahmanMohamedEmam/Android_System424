class UserStats {
  final int followersNumber;
  final int followingNumber;
  final int playlistsNumber;
  UserStats({
    this.followersNumber,
    this.followingNumber,
    this.playlistsNumber,
  });
  factory UserStats.fromjson(Map<String, dynamic> json) {
    return UserStats(
      followersNumber: json['followersNumber'],
      followingNumber: json['followingNumber'],
      playlistsNumber: json['playlistsNumber'],
    );
  }
}
