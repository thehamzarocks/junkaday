class User {
  String key;
  String email;
  int frownys;
  int health;
  List<String> rewards;
  List<String> consumables;
  String lastUpdated;

  User({this.key, this.email, this.frownys});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      key: json['key'],
      email: json['email'],
      frownys: json['frownys'],
    );
  }
}