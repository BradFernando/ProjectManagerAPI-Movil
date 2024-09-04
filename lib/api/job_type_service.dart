// services/job_type_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job_type.dart';

class JobTypeService {
  final String baseUrl = 'https://9558-2800-bf0-34a1-1020-851-ac84-aa74-5c08.ngrok-free.app/api/tipos-trabajo';

  Future<JobType?> getJobTypeById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return JobType.fromJson(data);
      } else {
        print('Error obteniendo tipo de trabajo: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error en la conexión: $e');
      return null;
    }
  }
}
