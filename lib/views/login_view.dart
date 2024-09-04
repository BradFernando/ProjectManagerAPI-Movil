// login_view.dart

import 'package:flutter/material.dart';
import '../api/area_service.dart';
import '../api/company_service.dart';
import '../api/employee_service.dart';
import '../api/job_type_service.dart';
import '../models/employee.dart';
import '../models/area.dart';
import '../models/company.dart';
import '../models/job_type.dart';
import 'home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _ciController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Estado para manejar el indicador de carga
  Employee? _employee;
  Area? _area;
  Company? _company;
  JobType? _jobType;

  void _fetchEmployeeData(String ci) async {
    setState(() {
      _isLoading = true; // Iniciar el indicador de carga
    });

    final employeeService = EmployeeService();
    final areaService = AreaService();
    final companyService = CompanyService();
    final jobTypeService = JobTypeService();

    try {
      Employee? employee = await employeeService.getEmployeeByCI(ci);
      if (employee != null) {
        Area? area = await areaService.getAreaById(employee.areaId);
        Company? company = await companyService.getCompanyById(area?.companyId ?? 0);
        JobType? jobType = await jobTypeService.getJobTypeById(employee.jobTypeId);

        setState(() {
          _employee = employee;
          _area = area;
          _company = company;
          _jobType = jobType;
          _isLoading = false; // Detener el indicador de carga
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(
              employee: employee,
              area: area,
              company: company,
              jobType: jobType,
            ),
          ),
        );
      } else {
        setState(() {
          _isLoading = false; // Detener el indicador de carga si no se encontró al empleado
        });
        _showErrorSnackbar('Empleado no encontrado.');
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Detener el indicador de carga en caso de error
      });
      _showErrorSnackbar('Error al obtener datos: ${e.toString()}');
    }
  }

  void _showErrorSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Sección superior (Formulario de login)
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.facebook, color: Colors.blue[800]),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.g_translate, color: Colors.red),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'necesitas ser empleado de la empresa:',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _ciController,
                            decoration: InputDecoration(
                              labelText: 'CI',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese su CI';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : () {
                                if (_formKey.currentState!.validate()) {
                                  _fetchEmployeeData(_ciController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: _isLoading ? Colors.green : Colors.blue[800],
                              ),
                              child: _isLoading
                                  ? const Text(
                                'Cargando...',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                                  : const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              // Sección inferior (Mensaje de bienvenida)
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)], // Gradiente ajustado
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: const Column(
                  children: [
                    Text(
                      'Saludos, nuevos usuarios!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Ingresa tu CI y continua con la experiencia de trabajar con nosotros.',
                      style: TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
