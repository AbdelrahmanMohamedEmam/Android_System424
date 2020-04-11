///Class Copyright which describes the copyright object.
class Copyright {
  ///The text for this copyright.
  final String text;

  ///The type of the copyright.
  final String type;

  ///Constructor for class album with named arguments assignment.
  Copyright({
    this.text,
    this.type,
  });

  ///A method that parses a mapped object from a json file and returns an Copyright object.
  factory Copyright.fromjson(Map<String, dynamic> json) {
    return Copyright(
      text: json['text'],
      type: json['type'],
    );
  }
}
