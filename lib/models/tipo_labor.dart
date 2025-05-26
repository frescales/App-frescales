class TipoLabor {
  final String id;
  final String nombre;
  final String? descripcion;

  TipoLabor({
    required this.id,
    required this.nombre,
    this.descripcion,
  });

  factory TipoLabor.fromMap(Map<String, dynamic> map) {
    return TipoLabor(
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
