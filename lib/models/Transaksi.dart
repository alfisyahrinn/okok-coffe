class Transaksi {
  String name;
  bool status;
  int total_harga;
  int user_id;
  int product_id;
  String? created_at;
  String? updated_at;
  Transaksi(
      {required this.name,
      required this.status,
      required this.total_harga,
      required this.user_id,
      required this.product_id,
      this.created_at,
      this.updated_at});
}
