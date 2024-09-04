class Task {
  final int id;
  final String title;
  final String description;
  final int employeeId;
  final String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.employeeId,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      employeeId: json['employeeId'],
      status: json['status'],
    );
  }
}
