///Class User Stats that describes the user's statistics.
class UserStats {
  ///The number of followers
  final int followersNumber;

  ///The number of users following this user.
  final int followingNumber;

  ///The number of playlists this user has created.
  final int playlistsNumber;

  ///Constructor for class UserStats with named arguments assignment.
  UserStats({
    this.followersNumber,
    this.followingNumber,
    this.playlistsNumber,
  });

  ///A method that parses a mapped object from a json file and returns an UserStats object.
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
