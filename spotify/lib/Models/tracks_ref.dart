///class TracksRef
class TracksRef {
  ///String having the href of the tracks of the object(playlist,album).
  final String href;

  ///The total number of tracks at this object(playlist,album).
  final int total;

  ///Constructor for tracks ref with named arguments assignment
  TracksRef({
    ///Initializations.
    this.href,
    this.total,
  });

  ///A method that parses a mapped object from a json file and returns a TracksRef object.
  factory TracksRef.fromJson(Map<String, dynamic> json) {
    return TracksRef(
      href: json['href'],
      total: json['total'],
    );
  }
}
