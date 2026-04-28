class Tarjeta {
  int id;
  String palabra;
  String traduccion;

  Tarjeta({
    required this.id,
    required this.palabra,
    required this.traduccion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'palabra': palabra,
      'traduccion': traduccion,
    };
  }

  factory Tarjeta.fromMap(Map<String, dynamic> map) {
    return Tarjeta(
      id: map['id'],
      palabra: map['palabra'],
      traduccion: map['traduccion'],
    );
  }
}