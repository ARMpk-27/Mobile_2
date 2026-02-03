class User {
  final int? id;
  final String username;
  final String email;

  User({
    this.id,
    required this.username,
    required this.email,
  });

  // แปลง Object → Map (ใช้ตอน insert/update)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }

  // แปลง Map → Object (ใช้ตอน query)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
    );
  }
}
