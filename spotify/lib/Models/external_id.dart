class ExternalId {
  final String type;
  final String id;
  ExternalId({
    this.type,
    this.id,
  });
    factory ExternalId.fromjson(Map<String, dynamic> json) {
    return ExternalId(
      type: json['type'],
      id: json['id'],
    );
    }
}