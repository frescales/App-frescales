class Unidad {
  final String id;
  final String nombre;
  final String simbolo;

  Unidad({
    required this.id,
    required this.nombre,
    required this.simbolo,
  });

  factory Unidad.fromMap(Map<String, dynamic> map) {
    return Unidad(
      id: map['id'] as String,
      nombre: map['nombre'] as String,
      simbolo: map['simbolo'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'simbolo': simbolo,
    };
  }
}
