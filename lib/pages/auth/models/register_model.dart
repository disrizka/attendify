class RegisterResponse {
  final String message;
  final Data data;

  RegisterResponse({required this.message, required this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final String token;
  final User user;

  Data({required this.token, required this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(token: json['token'], user: User.fromJson(json['user']));
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
