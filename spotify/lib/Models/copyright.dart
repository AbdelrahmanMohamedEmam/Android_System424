class Copyright {
  final String text;
  final String type;
  Copyright({
    this.text,
    this.type,
  });
  factory Copyright.fromjson(Map<String, dynamic> json) {
    return Copyright(
      text: json['text'],
      type: json['type'],
    );
  }
}
