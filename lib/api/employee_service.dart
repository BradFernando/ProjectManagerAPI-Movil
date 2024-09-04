import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/employee.dart';

class EmployeeService {
  final String baseUrl = 'https://9558-2800-bf0-34a1-1020-851-ac84-aa74-5c08.ngrok-free.app/api/empleados';

  Future<Employee?> getEmployeeByCI(String ci) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/ci/$ci'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        // Decodifica la respuesta con UTF-8
        final data = json.decode(utf8.decode(response.bodyBytes));
        return Employee.fromJson(data);
      } else {
        print('Error obteniendo empleado: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error en la conexión: $e');
      return null;
    }
  }
}
