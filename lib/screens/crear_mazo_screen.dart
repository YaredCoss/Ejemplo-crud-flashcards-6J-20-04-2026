import 'package:flutter/material.dart';
import '../services/lista_mazos.dart';
import '../models/mazo.dart';

class CrearMazoScreen extends StatefulWidget {
  final Mazo? mazoEditar;

  CrearMazoScreen({this.mazoEditar});

  @override
  _CrearMazoScreenState createState() => _CrearMazoScreenState();
}

class _CrearMazoScreenState extends State<CrearMazoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _listaMazos = ListaMazos();

  @override
  void initState() {
    super.initState();
    if (widget.mazoEditar != null) {
      _nombreController.text = widget.mazoEditar!.nombre;
      _descripcionController.text = widget.mazoEditar!.descripcion;
      _cantidadController.text = widget.mazoEditar!.cantidad.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mazoEditar == null ? 'Crear Mazo' : 'Editar Mazo'),
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
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del Mazo',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(Icons.folder, color: Colors.orange.shade700),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un nombre';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descripcionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(Icons.description, color: Colors.orange.shade700),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una descripción';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _cantidadController,
                  decoration: InputDecoration(
                    labelText: 'Cantidad de Tarjetas',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(Icons.numbers, color: Colors.orange.shade700),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una cantidad';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Ingrese un número válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _guardarMazo,
                  child: Text(
                    'GUARDAR MAZO',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _guardarMazo() {
    if (_formKey.currentState!.validate()) {
      final mazo = Mazo(
        id: widget.mazoEditar?.id ?? 0,
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        cantidad: int.parse(_cantidadController.text),
      );

      _listaMazos.insertarMazo(mazo);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.mazoEditar == null 
              ? '¡Mazo creado exitosamente!' 
              : '¡Mazo actualizado exitosamente!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }
}