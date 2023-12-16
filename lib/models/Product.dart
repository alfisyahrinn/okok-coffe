class Product {
  String name;
  String harga;
  int category_id;
  String? created_at;
  String? updated_at;
  Product({
    required this.name,
    required this.harga,
    required this.category_id,
    this.created_at,
    this.updated_at
  });

}
