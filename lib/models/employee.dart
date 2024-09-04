// models/employee.dart
class Employee {
  final int id;
  final String ci;  // Este es el campo requerido que falta
  final String firstName;
  final String lastName;
  final String email;
  final int areaId;
  final int jobTypeId;

  Employee({
    required this.id,
    required this.ci,  // Asegúrate de que este campo esté siempre proporcionado
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.areaId,
    required this.jobTypeId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      ci: json['ci'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      areaId: json['areaId'],
      jobTypeId: json['jobTypeId'],
    );
  }
}
