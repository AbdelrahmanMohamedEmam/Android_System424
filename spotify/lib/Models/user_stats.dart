class UserStats {
  final int followersNumber;
  final int followingNumber;
  final int playlistsNumber;
  UserStats({
    this.followersNumber,
    this.followingNumber,
    this.playlistsNumber,
  });
  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      followersNumber:
          json['followersNumber'] == null ? 0 : json['followersNumber'],
      followingNumber:
          json['followingNumber'] == null ? 0 : json['followingNumber'],
      playlistsNumber:
          json['playlistsNumber'] == null ? 0 : json['playlistsNumber'],
    );
  }
}
