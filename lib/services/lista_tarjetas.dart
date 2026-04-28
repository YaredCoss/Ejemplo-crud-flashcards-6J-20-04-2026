import '../models/tarjeta.dart';

class ListaTarjetas {
  static final ListaTarjetas _instance = ListaTarjetas._internal();
  factory ListaTarjetas() => _instance;
  ListaTarjetas._internal();

  Map<int, Tarjeta> datosTarjetas = {};
  int _currentId = 1;

  int get nextId => _currentId++;

  void insertarTarjeta(Tarjeta tarjeta) {
    if (tarjeta.id == 0) {
      Tarjeta nuevaTarjeta = Tarjeta(
        id: nextId,
        palabra: tarjeta.palabra,
        traduccion: tarjeta.traduccion,
      );
      datosTarjetas[nuevaTarjeta.id] = nuevaTarjeta;
    } else {
      datosTarjetas[tarjeta.id] = tarjeta;
    }
  }

  void actualizarTarjeta(Tarjeta tarjeta) {
    datosTarjetas[tarjeta.id] = tarjeta;
  }

  void eliminarTarjeta(int id) {
    datosTarjetas.remove(id);
  }

  Tarjeta? obtenerTarjeta(int id) {
    return datosTarjetas[id];
  }

  List<Tarjeta> obtenerTodasLasTarjetas() {
    return datosTarjetas.values.toList();
  }
}