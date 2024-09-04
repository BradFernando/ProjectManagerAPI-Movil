import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/company.dart';

class CompanyService {
  final String baseUrl = 'https://9558-2800-bf0-34a1-1020-851-ac84-aa74-5c08.ngrok-free.app/api/empresas';

  Future<Company?> getCompanyById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Company.fromJson(data);
      } else {
        print('Error obteniendo compañía: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error en la conexión: $e');
      return null;
    }
  }
}
