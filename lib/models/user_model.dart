
class User{
  final String fullName;
  final String username;
  final String password;

  User({
    required this.fullName,
    required this.username,
    required this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      username: json['username'],
      password: json['password']
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'username': username,
      'password': password
    };
  }

}