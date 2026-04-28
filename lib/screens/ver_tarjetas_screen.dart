import 'package:flutter/material.dart';
import '../services/lista_tarjetas.dart';
import '../models/tarjeta.dart';
import 'crear_tarjeta_screen.dart';

class VerTarjetasScreen extends StatefulWidget {
  @override
  _VerTarjetasScreenState createState() => _VerTarjetasScreenState();
}

class _VerTarjetasScreenState extends State<VerTarjetasScreen> {
  final _listaTarjetas = ListaTarjetas();
  bool _mostrarTraduccion = false;

  @override
  Widget build(BuildContext context) {
    final tarjetas = _listaTarjetas.obtenerTodasLasTarjetas();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Tarjetas'),
        actions: [
          IconButton(
            icon: Icon(
              _mostrarTraduccion ? Icons.visibility_off : Icons.visibility,
              color: Colors.orange.shade700,
            ),
            onPressed: () {
              setState(() {
                _mostrarTraduccion = !_mostrarTraduccion;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.orange.shade700),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrearTarjetaScreen()),
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
        child: tarjetas.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.style,
                      size: 80,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No hay tarjetas creadas',
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
                          MaterialPageRoute(builder: (context) => CrearTarjetaScreen()),
                        ).then((_) => setState(() {}));
                      },
                      child: Text('Crear mi primera tarjeta'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: tarjetas.length,
                itemBuilder: (context, index) {
                  final tarjeta = tarjetas[index];
                  return _buildTarjetaCard(tarjeta);
                },
              ),
      ),
    );
  }

  Widget _buildTarjetaCard(Tarjeta tarjeta) {
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
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        tarjeta.palabra,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (_mostrarTraduccion) ...[
                        SizedBox(height: 16),
                        Container(
                          height: 1,
                          color: Colors.grey.shade700,
                        ),
                        SizedBox(height: 16),
                        Text(
                          tarjeta.traduccion,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.orange.shade400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
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
                          builder: (context) => CrearTarjetaScreen(tarjetaEditar: tarjeta),
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
                      _confirmarEliminacion(tarjeta);
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

  void _confirmarEliminacion(Tarjeta tarjeta) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade800,
        title: Text(
          'Eliminar Tarjeta',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          '¿Estás seguro de que deseas eliminar la tarjeta "${tarjeta.palabra}"?',
          style: TextStyle(color: Colors.grey.shade400),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              _listaTarjetas.eliminarTarjeta(tarjeta.id);
              setState(() {});
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tarjeta eliminada exitosamente'),
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