import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards Estudio'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.orange.shade700),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade900,
              Colors.grey.shade800,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.school,
                        size: 100,
                        color: Colors.orange.shade700,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '¡Bienvenido a tu centro\nde estudio!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 40),
                      _buildMenuCard(
                        context: context,
                        title: 'Mis Mazos',
                        subtitle: 'Gestiona tus colecciones de tarjetas',
                        icon: Icons.grid_view,
                        color: Colors.orange.shade700,
                        onTap: () {
                          Navigator.pushNamed(context, '/ver_mazos');
                        },
                      ),
                      SizedBox(height: 16),
                      _buildMenuCard(
                        context: context,
                        title: 'Mis Tarjetas',
                        subtitle: 'Crea y administra tus flashcards',
                        icon: Icons.style,
                        color: Colors.orange.shade700,
                        onTap: () {
                          Navigator.pushNamed(context, '/ver_tarjetas');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            backgroundColor: Colors.grey.shade900,
            builder: (context) => Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildBottomSheetOption(
                    context: context,
                    title: 'Crear Nuevo Mazo',
                    icon: Icons.create_new_folder,
                    route: '/crear_mazo',
                  ),
                  Divider(color: Colors.grey.shade700),
                  _buildBottomSheetOption(
                    context: context,
                    title: 'Crear Nueva Tarjeta',
                    icon: Icons.add_card,
                    route: '/crear_tarjeta',
                  ),
                ],
              ),
            ),
          );
        },
        backgroundColor: Colors.orange.shade700,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildMenuCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade700),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 30, color: color),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.orange.shade700, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetOption({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String route,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange.shade700),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}