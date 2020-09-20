class User {
  String key;
  String email;
  int health;
  int maxHealth;
  int mints;
  bool isSpirit;
  int mileStone;
  List<String> rewards;
  List<String> consumables;
  String lastUpdated;

  User({this.key, this.email, this.health, this.maxHealth, this.mints, this.isSpirit, this.mileStone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      key: json['key'],
      email: json['email'],
      health: json['health'],
      maxHealth: json['maxHealth'],
      mints: json['mints'],
      isSpirit: json['isSpirit'],
      mileStone: json['mileStone']
    );
  }
}