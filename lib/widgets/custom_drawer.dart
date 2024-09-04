import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menú'),
          ),
          ListTile(
            title: const Text('Inicio'),
            onTap: () {
              // Navegar a la vista deseada
            },
          ),
          // Añade más opciones según sea necesario
        ],
      ),
    );
  }
}
