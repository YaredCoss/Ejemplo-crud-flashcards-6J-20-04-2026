import 'package:flutter/material.dart';
import '../services/lista_tarjetas.dart';
import '../models/tarjeta.dart';

class CrearTarjetaScreen extends StatefulWidget {
  final Tarjeta? tarjetaEditar;

  CrearTarjetaScreen({this.tarjetaEditar});

  @override
  _CrearTarjetaScreenState createState() => _CrearTarjetaScreenState();
}

class _CrearTarjetaScreenState extends State<CrearTarjetaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _palabraController = TextEditingController();
  final _traduccionController = TextEditingController();
  final _listaTarjetas = ListaTarjetas();

  @override
  void initState() {
    super.initState();
    if (widget.tarjetaEditar != null) {
      _palabraController.text = widget.tarjetaEditar!.palabra;
      _traduccionController.text = widget.tarjetaEditar!.traduccion;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarjetaEditar == null ? 'Crear Tarjeta' : 'Editar Tarjeta'),
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
                  controller: _palabraController,
                  decoration: InputDecoration(
                    labelText: 'Palabra/Término',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(Icons.text_fields, color: Colors.orange.shade700),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una palabra';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _traduccionController,
                  decoration: InputDecoration(
                    labelText: 'Traducción/Definición',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(Icons.translate, color: Colors.orange.shade700),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una traducción o definición';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _guardarTarjeta,
                  child: Text(
                    'GUARDAR TARJETA',
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

  void _guardarTarjeta() {
    if (_formKey.currentState!.validate()) {
      final tarjeta = Tarjeta(
        id: widget.tarjetaEditar?.id ?? 0,
        palabra: _palabraController.text,
        traduccion: _traduccionController.text,
      );

      _listaTarjetas.insertarTarjeta(tarjeta);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.tarjetaEditar == null 
              ? '¡Tarjeta creada exitosamente!' 
              : '¡Tarjeta actualizada exitosamente!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _palabraController.dispose();
    _traduccionController.dispose();
    super.dispose();
  }
}