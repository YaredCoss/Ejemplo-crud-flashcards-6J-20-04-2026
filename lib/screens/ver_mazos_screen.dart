import 'package:flutter/material.dart';
import '../services/lista_mazos.dart';
import '../models/mazo.dart';
import 'crear_mazo_screen.dart';

class VerMazosScreen extends StatefulWidget {
  @override
  _VerMazosScreenState createState() => _VerMazosScreenState();
}

class _VerMazosScreenState extends State<VerMazosScreen> {
  final _listaMazos = ListaMazos();

  @override
  Widget build(BuildContext context) {
    final mazos = _listaMazos.obtenerTodosLosMazos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Mazos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.orange.shade700),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrearMazoScreen()),
              ).then((_) => setState(() {}));
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
        child: mazos.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open,
                      size: 80,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No hay mazos creados',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CrearMazoScreen()),
                        ).then((_) => setState(() {}));
                      },
                      child: Text('Crear mi primer mazo'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: mazos.length,
                itemBuilder: (context, index) {
                  final mazo = mazos[index];
                  return _buildMazoCard(mazo);
                },
              ),
      ),
    );
  }

  Widget _buildMazoCard(Mazo mazo) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade700.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.folder,
                        color: Colors.orange.shade700,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mazo.nombre,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            mazo.descripcion,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.numbers,
                      size: 16,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${mazo.cantidad} tarjetas',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CrearMazoScreen(mazoEditar: mazo),
                        ),
                      ).then((_) => setState(() {}));
                    },
                    icon: Icon(Icons.edit, color: Colors.orange.shade700),
                    label: Text(
                      'Editar',
                      style: TextStyle(color: Colors.orange.shade700),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.grey.shade700,
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      _confirmarEliminacion(mazo);
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                    label: Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmarEliminacion(Mazo mazo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade800,
        title: Text(
          'Eliminar Mazo',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          '¿Estás seguro de que deseas eliminar el mazo "${mazo.nombre}"?',
          style: TextStyle(color: Colors.grey.shade400),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              _listaMazos.eliminarMazo(mazo.id);
              setState(() {});
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Mazo eliminado exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}