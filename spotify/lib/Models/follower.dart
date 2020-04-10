///Class Follower that represents the follower object.
class Follower {
  ///A link to the web api end point providing all details of this Category.
  final String href;

  ///The total number of followers.
  final int total;

  ///Constructor for class follower with named arguments assignment.
  Follower({
    this.href,
    this.total,
  });

  ///A method that parses a mapped object from a json file and returns a follower object.
  factory Follower.fromjson(Map<String, dynamic> json) {
    return Follower(
      href: json['href'] == null ? null : json['href'],
      total: json['total'] == null ? 0 : json['total'],
    );
  }
}
