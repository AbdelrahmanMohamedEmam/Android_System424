class Category {
  final String name;
  final String id;
  final String href;
  Category({
    this.name,
    this.id,
    this.href,
  });
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      href: json['href'],
    );
  }
}
