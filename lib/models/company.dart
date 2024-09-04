// models/company.dart
class Company {
  final int id;
  final String name;
  final String description;
  final String avatar;

  Company({
    required this.id,
    required this.name,
    required this.description,
    required this.avatar,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      avatar: json['avatar'],
    );
  }
}
