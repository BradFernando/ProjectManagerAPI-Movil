// views/home_view.dart

import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../models/area.dart';
import '../models/company.dart';
import '../models/job_type.dart';
import '../widgets/header_widget.dart';
import '../widgets/user_info_card.dart';

class HomeView extends StatelessWidget {
  final Employee employee;
  final Area? area;
  final Company? company;
  final JobType? jobType;

  const HomeView({
    super.key,
    required this.employee,
    this.area,
    this.company,
    this.jobType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(
        userInitial: employee.firstName[0], // Utiliza la inicial del nombre del usuario
        employeeId: employee.id, // Pasa el employeeId aquí
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0), // Añade un padding superior
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Cambia a 'start' para alinear al principio
          children: [
            UserInfoCard(
              employee: employee,
              area: area,
              company: company,
              jobType: jobType,
            ),
          ],
        ),
      ),
    );
  }
}
