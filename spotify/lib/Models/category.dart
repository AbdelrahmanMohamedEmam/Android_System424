///Category class
class Category {
  ///The name of the category.
  final String name;

  ///The unique identifier of this category.
  final String id;

  ///A link to the web api end point providing all details of this Category.
  final String href;

  ///Constructor for class category with named arguments assignment.
  Category({
    ///Initializations.
    this.name,
    this.id,
    this.href,
  });

  ///A method that parses a mapped object from a json file and returns a category object.
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      href: json['href'],
    );
  }
}
