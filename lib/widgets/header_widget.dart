// widgets/header_widget.dart

import 'package:flutter/material.dart';
import '../api/report_service.dart';
import '../models/report_response.dart'; // Importar el modelo ReportResponse
import '../views/login_view.dart';

class HeaderWidget extends StatefulWidget implements PreferredSizeWidget {
  final String userInitial;
  final int employeeId; // Añadir el parámetro employeeId

  const HeaderWidget({
    super.key,
    required this.userInitial,
    required this.employeeId,
  });

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(80.0);
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final ReportService _reportService = ReportService();
  List<ReportResponse> _notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchReports(); // Obtener los reportes cuando se inicializa el widget
  }

  void _fetchReports() async {
    try {
      List<ReportResponse> reports = await _reportService.getReportsByEmployeeId(widget.employeeId);
      if (reports.isEmpty) {
        print('No reports found for employee ID: ${widget.employeeId}');
      } else {
        print('Found ${reports.length} reports for employee ID: ${widget.employeeId}');
      }

      setState(() {
        _notifications = reports;
      });
    } catch (e) {
      print('Error fetching reports: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.grey[600]),
            onPressed: () {
              _showNotificationsPanel(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.message_outlined, color: Colors.grey[600]),
            onPressed: () {
              // Acción de mensaje
            },
          ),
          PopupMenuButton<String>(
            icon: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(
                widget.userInitial,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onSelected: (String result) {
              if (result == 'Cerrar sesión') {
                _showLogoutDialog(context);
              } else {
                print('Opción seleccionada: $result');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Perfil',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Perfil'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Configuración',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Configuración'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Bloquear',
                child: ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Bloquear'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Cerrar sesión',
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Cerrar sesión'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showNotificationsPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        if (_notifications.isEmpty) {
          return const Center(child: Text('No hay notificaciones disponibles.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            return ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text('Nuevo reporte disponible'),
              subtitle: Text('Haga clic para descargar el reporte'),
              onTap: () {
                print('Downloading report from URL: ${notification.downloadUrl}');
                // Pasar el contexto correcto al método downloadPdf
                _reportService.downloadPdf(context, notification.downloadUrl);
              },
            );
          },
        );
      },
    );
  }


  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Gracias'),
          content: Text('Gracias por usar la aplicación. ¡Te esperamos pronto!'),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
