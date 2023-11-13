class User {
  String name;
  String email;
  String password;
  String? created_at;
  String? updated_at;
  User({
    required this.name,
    required this.email,
    required this.password,
    this.created_at,
    this.updated_at
  });
}
