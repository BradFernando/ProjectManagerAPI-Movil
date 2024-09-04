import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../models/area.dart';
import '../models/company.dart';
import '../models/job_type.dart';

class UserInfoCard extends StatelessWidget {
  final Employee employee;
  final Area? area;
  final Company? company;
  final JobType? jobType;

  const UserInfoCard({
    super.key,
    required this.employee,
    this.area,
    this.company,
    this.jobType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${employee.firstName} ${employee.lastName}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.email, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Email: ${employee.email}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.credit_card, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Cédula: ${employee.ci}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            if (area != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.business, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Área: ${area!.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (jobType != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.work, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Tipo de Trabajo: ${jobType!.description}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (company != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.apartment, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Compañía: ${company!.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
