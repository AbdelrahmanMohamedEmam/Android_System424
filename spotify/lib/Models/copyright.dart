class CopyRight {
  final String text;
  final String type;
  CopyRight({
    this.text,
    this.type,
  });
  factory CopyRight.fromjson(Map<String, dynamic> json) {
    return CopyRight(
      text: json['text'],
      type: json['type'],
    );
  }
}
