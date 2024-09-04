// models/job_type.dart
class JobType {
  final int id;
  final String description;

  JobType({
    required this.id,
    required this.description,
  });

  factory JobType.fromJson(Map<String, dynamic> json) {
    return JobType(
      id: json['id'],
      description: json['description'],
    );
  }
}
