class Category {
  final String label;
  final List<Category> items;

  Category(this.label, this.items);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(json['label'], (json['items'] as List).map((item) => Category.fromJson(item)));
  }
}

class CategoryResponse {
  final int code;
  final List<Category> categories;

  CategoryResponse(this.code, this.categories);

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(json['code'], (json['msg'] as List).map((category) => Category.fromJson(category)));
  }
}
