class Ubicacion {
  final String id;
  final String nombre;
  final String? descripcion;

  Ubicacion({
    required this.id,
    required this.nombre,
    this.descripcion,
  });

  factory Ubicacion.fromMap(Map<String, dynamic> map) {
    return Ubicacion(
      id: map['id'] as String,
      nombre: map['nombre'] as String,
      descripcion: map['descripcion'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}
