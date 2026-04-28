import '../models/mazo.dart';

class ListaMazos {
  static final ListaMazos _instance = ListaMazos._internal();
  factory ListaMazos() => _instance;
  ListaMazos._internal();

  Map<int, Mazo> datosMazos = {};
  int _currentId = 1;

  int get nextId => _currentId++;

  void insertarMazo(Mazo mazo) {
    if (mazo.id == 0) {
      Mazo nuevoMazo = Mazo(
        id: nextId,
        nombre: mazo.nombre,
        descripcion: mazo.descripcion,
        cantidad: mazo.cantidad,
      );
      datosMazos[nuevoMazo.id] = nuevoMazo;
    } else {
      datosMazos[mazo.id] = mazo;
    }
  }

  void actualizarMazo(Mazo mazo) {
    datosMazos[mazo.id] = mazo;
  }

  void eliminarMazo(int id) {
    datosMazos.remove(id);
  }

  Mazo? obtenerMazo(int id) {
    return datosMazos[id];
  }

  List<Mazo> obtenerTodosLosMazos() {
    return datosMazos.values.toList();
  }
}