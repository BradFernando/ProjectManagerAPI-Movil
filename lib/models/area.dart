// models/area.dart
class Area {
  final int id;
  final String name;
  final int companyId;

  Area({
    required this.id,
    required this.name,
    required this.companyId,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      name: json['name'],
      companyId: json['companyId'],
    );
  }
}
