class TipoActividad {
  final String id;
  final String nombre;
  final String? descripcion;

  TipoActividad({
    required this.id,
    required this.nombre,
    this.descripcion,
  });

  factory TipoActividad.fromMap(Map<String, dynamic> map) {
    return TipoActividad(
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
