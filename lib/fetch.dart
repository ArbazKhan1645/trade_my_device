import 'manage_data.dart';

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
    );
  }
}

fetchusers()async{
  // Use the service
final apiService = ApiService();

// GET request
final userResponse = await apiService.get<Userc>(
  url: 'https://api.example.com/users/1',
  fromJson: Userc.fromJson,
);

if (userResponse.success) {
  final user = userResponse.data;
  print(user?.arbaz);
}

// POST request
final newUser = await apiService.post<User>(
  url: 'https://api.example.com/users',
  fromJson: User.fromJson,
  body: {'name': 'John Doe'},
);

// DELETE request
final deleted = await apiService.delete(
  url: 'https://api.example.com/users/1',
);
}


class Userc {
  final int id;
  final String arbaz;

  Userc({required this.id, required this.arbaz});

  factory Userc.fromJson(Map<String, dynamic> json) {
    return Userc(
      id: json['id'],
      arbaz: json['arbaz'],
    );
  }
}