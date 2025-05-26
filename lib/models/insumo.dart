class Insumo {
  final String id;
  final String nombre;
  final String? descripcion;

  Insumo({
    required this.id,
    required this.nombre,
    this.descripcion,
  });

  factory Insumo.fromMap(Map<String, dynamic> map) {
    return Insumo(
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
