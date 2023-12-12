class CategoryModel {
  String name;
  String? created_at;
  String? updated_at;
  CategoryModel({required this.name, this.created_at, this.updated_at});

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];
    categories.add(
      CategoryModel(name: "All"),
    );
    categories.add(
      CategoryModel(name: "Makanan"),
    );
    categories.add(
      CategoryModel(name: "Minuman"),
    );
    categories.add(
      CategoryModel(name: "Cemilan"),
    );
    categories.add(
      CategoryModel(name: "Marchendise"),
    );
    return categories;
  }
}
