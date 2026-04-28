class Mazo {
  int id;
  String nombre;
  String descripcion;
  int cantidad;

  Mazo({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.cantidad,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'cantidad': cantidad,
    };
  }

  factory Mazo.fromMap(Map<String, dynamic> map) {
    return Mazo(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      cantidad: map['cantidad'],
    );
  }
}