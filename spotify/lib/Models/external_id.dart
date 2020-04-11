///Class externalid which describes the externalId model.
class ExternalId {
  ///The type of the external Id.
  final String type;

  ///The unique identifier for this externalId object.
  final String id;

  ///Constructor for class ExternalId with named arguments assignment.
  ExternalId({
    this.type,
    this.id,
  });

  ///A method that parses a mapped object from a json file and returns an ExternalId object.
  factory ExternalId.fromjson(Map<String, dynamic> json) {
    return ExternalId(
      type: json['type'] == null ? "" : json['type'],
      id: json['_id'] == null ? "" : json['_id'],
    );
  }
}
