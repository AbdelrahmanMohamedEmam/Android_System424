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
          json['followersNumber'] == null ? null : json['followersNumber'],
      followingNumber:
          json['followingNumber'] == null ? null : json['followingNumber'],
      playlistsNumber:
          json['playlistsNumber'] == null ? null : json['playlistsNumber'],
    );
  }
}
