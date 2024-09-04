import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';  // Importar file_picker
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';  // Importar open_filex
import '../models/report_response.dart';

class ReportService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://9558-2800-bf0-34a1-1020-851-ac84-aa74-5c08.ngrok-free.app/api/reportes-trabajo';

  Future<List<ReportResponse>> getReportsByEmployeeId(int employeeId) async {
    try {
      final response = await _dio.get('$baseUrl/employee/$employeeId');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ReportResponse.fromJson(json)).toList();
      } else {
        print('Error obteniendo los reportes: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error en la conexión: $e');
      return [];
    }
  }

  Future<void> downloadPdf(BuildContext context, String downloadUrl) async {
    try {
      // Construir la URL completa para la descarga
      String fullUrl = 'https://9558-2800-bf0-34a1-1020-851-ac84-aa74-5c08.ngrok-free.app$downloadUrl';
      print('Downloading PDF from URL: $fullUrl');

      // Mostrar un selector de archivos para elegir la ubicación de guardado
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory == null) {
        // El usuario canceló la selección
        print('Selección de carpeta cancelada.');
        return;
      }

      final filePath = '$selectedDirectory/reporte_descargado_${DateTime.now().millisecondsSinceEpoch}.pdf';

      // Descargar el archivo y mostrar progreso
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DownloadProgressDialog(
            fullUrl: fullUrl,
            filePath: filePath,
            onDownloadComplete: (String path) {
              Navigator.of(context).pop(); // Cerrar el diálogo de progreso
              _openDownloadedFile(path); // Abrir el archivo descargado
            },
          );
        },
      );
    } catch (e) {
      print('Error en la conexión o en el proceso de guardado: $e');
    }
  }


  void _openDownloadedFile(String filePath) async {
    final result = await OpenFilex.open(filePath);
    if (result.type == ResultType.error) {
      print('Error abriendo el archivo: ${result.message}');
    } else {
      print('Archivo abierto correctamente: $filePath');
    }
  }
}

class DownloadProgressDialog extends StatefulWidget {
  final String fullUrl;
  final String filePath;
  final Function(String) onDownloadComplete;

  const DownloadProgressDialog({
    super.key,
    required this.fullUrl,
    required this.filePath,
    required this.onDownloadComplete,
  });

  @override
  _DownloadProgressDialogState createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startDownload();
  }

  void _startDownload() async {
    try {
      final response = await Dio().download(
        widget.fullUrl,
        widget.filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              progress = received / total;
            });
          }
        },
      );

      if (response.statusCode == 200) {
        print('Archivo descargado correctamente y guardado en: ${widget.filePath}');
        widget.onDownloadComplete(widget.filePath);
      } else {
        print('Error descargando el archivo: ${response.statusCode}');
        Navigator.of(context).pop(); // Cerrar el diálogo de progreso
      }
    } catch (e) {
      print('Error en la conexión o en el proceso de guardado: $e');
      Navigator.of(context).pop(); // Cerrar el diálogo de progreso
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Descargando PDF'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: progress),
          const SizedBox(height: 20),
          Text('${(progress * 100).toStringAsFixed(0)}%'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Permitir cancelar la descarga
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
